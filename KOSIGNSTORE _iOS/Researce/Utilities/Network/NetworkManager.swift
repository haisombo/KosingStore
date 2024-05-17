//
//  NetworkManager.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 4/30/24.
//

import Foundation
import Combine


public class NetworkManager : NSObject, URLSessionDelegate {
    
    //MARK: - properties -
    private static var sharedInstance   = NetworkManager()
    
    // The Network access for request, response, upload and download task
    private static var sessionConfig    : URLSessionConfiguration!
    private static var session          : URLSession!
    let progress                        : PassthroughSubject<(id: Int, progress: Double), Never>    = .init()
    let subject                         : PassthroughSubject<UploadResponse, Error>                 = .init()
    
    private var cancellables            = Set<AnyCancellable>()
    private var retryCountRequest       = 10000 // retry request count
    /// SET TIME DELAY
    private var delayRetryRequest       = 3     // delay request in second
    
    public static var shared: NetworkManager = {
        // Timeout Configuration
        sessionConfig                               = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest     = 120.0
        sessionConfig.timeoutIntervalForResource    = 120.0
        // url session delegate
        session                                     = URLSession(configuration: NetworkManager.sessionConfig, delegate: NetworkManager.sharedInstance, delegateQueue: .main)
        return sharedInstance
    }()
    
    //MARK: - check manualError -
    private func manualError(err: NSError) -> NSError {
        // Custom NSError
#if DEBUG
        print("Connection server error : \(err.domain)")
#endif
        switch err.code  {
            
            /**  -1001 : request timed out
             -1003 : hostname could not be found
             -1004 : Can't connect to host
             -1005 : Network connection lost
             -1009 : No internet connection
             */
        case -1001, -1003, -1004: // request timed out
            let error = NSError(domain: "NSURLErrorDomain", code: err.code, userInfo: [NSLocalizedDescriptionKey : "connection_time_out"])
            return error
        case -1005 : // Network connection lost
            let error = NSError(domain: "NSURLErrorDomain", code: err.code, userInfo: [NSLocalizedDescriptionKey : "internet_connection_is_unstable_please_try_again_after_connecting"])
            return error
        case -1009 : // No internet connection
            let error = NSError(domain: "NSURLErrorDomain", code: err.code, userInfo: [NSLocalizedDescriptionKey : "internet_connection_is_unstable_please_try_again_after_connecting"])
            return error
        default :
            return err
        }
    }
    
    //MARK: - check internet connection -
    private func checkInternetRequest(URLError error: URLError) -> Bool {
        switch error.errorCode {
        case -1001, -1003, -1004, -1005, -1009:
            return true
        default: return false
        }
    }
    
    private override init() {}
    
    //MARK: - request data with dataTaskPublisher -
    public func request<I: Encodable, O: Decodable>(shouldShowLoading          : Bool                          = true,
                                                    baseURL                    : String                        = APIKey.baseURL,
                                                    pathVariable               : [String]?                     = nil,
                                                    urlParam                   : Dictionary<String, String>?   = nil,
                                                    endpoint                   : APIKey,
                                                    httpMethod                 : HTTPMethod,
                                                    body                       : I                             = "",
                                                    responseType               : O.Type) -> Future<O, Error> {
        
        if shouldShowLoading {
            DispatchQueue.main.async {
//                LoadingView.show()
            }
        }
        
        let request = self.getURLRequest(baseURL        : baseURL,
                                         endpoint       : endpoint,
                                         pathVariable   : pathVariable,
                                         urlParam       : urlParam,
                                         body           : body,
                                         httpMethod     : httpMethod)
        
        return Future<O, Error> { [weak self] promise in
            
            /// -  check if url is valid
            guard let self = self, let url = URL(string: APIKey.baseURL) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            
            /// -  combine network request with dataTaskPublisher
            NetworkManager.session.dataTaskPublisher(for: request)
            
            /// - IF YOU WANT HANDLE ERROR BEFORE GET DATA
            /// - trycatch:  handle error and and return publisher to upStream
            
                .tryCatch { (error) -> AnyPublisher<(data: Data, response: URLResponse), URLError> in
                    print("Try to handle an error")
                    guard self.checkInternetRequest(URLError: error) else {
                        throw error
                    }
                    /// - make unlimited call request when internet connection is unstable
                    print("Re-try a request")
                    
                    /// - return Fail publisher
                    return Fail(error: error)
                        .delay(for: .seconds(self.delayRetryRequest), scheduler: DispatchQueue.main) // delay request
                        .eraseToAnyPublisher()
                }
                .retry(self.retryCountRequest) // retry request
            
                // indicating that the subscriber should execute its work on a background queue with a quality of service
                .subscribe(on: DispatchQueue.global(qos: .default ))
            
            /// - tryMap : handle data, response and error from Upstream
                .tryMap { (data, response) -> Data in
                    
                    //MARK: - Check Data, Response Error
                    let decodedDataString  = String(data: data, encoding: String.Encoding.utf8)?.removingPercentEncoding
                    guard let responseData = decodedDataString == nil ? data : decodedDataString?.data(using: .utf8) else {
                        let nsError = NSError(domain: "ClientError", code: 168, userInfo: [NSLocalizedDescriptionKey : "Could not convert string to data."])
                        
#if DEBUG
                        print("""
                    \(nsError.code) | \(nsError.localizedDescription)
                    """)
#endif
                        promise(.failure(nsError))
                        throw nsError
                    }
                    
#if DEBUG
                    Log("""
                                    \(request.url!) | \(endpoint.rawValue)
                                    \(responseData.prettyPrinted)
                                    """)
#endif
                    
                    let _ = responseData.dataToDic
                    
                    guard let _ = try? JSONDecoder().decode(responseType, from: responseData) else {
                        
                        if responseData.prettyPrinted == "{\n\n}" {
                            print("Pretty Print nnnn")
                        } else {
                            print("Response has no key error")
                        }
                        promise(.failure(NetworkError.decoding))
                        throw NetworkError.decoding
                    }
                    
                    let fields = (response as! HTTPURLResponse).allHeaderFields as? [String: String]
                    
                    // Set cookie to use with Web
                    let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields ?? ["": ""], for: url)
                    HTTPCookieStorage.shared.setCookies(cookies, for: url, mainDocumentURL: nil)
                    for cookie in cookies {
                        var cookieProperties        = [HTTPCookiePropertyKey: Any]()
                        cookieProperties[.name]     = cookie.name
                        cookieProperties[.value]    = cookie.value
                        cookieProperties[.domain]   = cookie.domain
                        cookieProperties[.path]     = cookie.path
                        cookieProperties[.version]  = cookie.version
                        cookieProperties[.expires]  = Date().addingTimeInterval(31536000)
                        
                        Shared.share.jSessionId     = "\(cookie.name)=\(cookie.value)"
                        
                        if let cookie = HTTPCookie(properties: cookieProperties) {
                            HTTPCookieStorage.shared.setCookie(cookie)
                        }
                        
#if DEBUG
                        print("name: \(cookie.name) value: \(cookie.value)")
#endif
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
            /// - decode data
                .decode(type: responseType, decoder: JSONDecoder())
            
            /// - receive: set scheduler on receiving data
                .receive(on: DispatchQueue.main)
            
            /// - sink: observe values
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        Log.e("""
                                        \(request.url!) | \(endpoint.rawValue)
                                        
                                        \(error)
                                        """)
                        promise(.failure(error))
                    }
                    if shouldShowLoading {
                        DispatchQueue.main.async {
                            /// this block is for custom dismiss loading view
                        }
                    }
                }, receiveValue: {
                    Log.s("""
                                    \(request.url!) | \(endpoint.rawValue)
                                    
                                    \(($0 as AnyObject))
                                    """)
                    promise(.success($0))
                })
            
                .store(in: &self.cancellables)
        }
    }
    
    //MARK: - DownloadTask - using with combine and response progress real time
    public func download<I: Encodable, O: Decodable>(baseURL            : String                        = APIKey.baseURL,
                                                     endpoint           : APIKey?                       = nil,
                                                     rawURL             : String?                       = nil,
                                                     contentType        : ContentType                   = .FormData,
                                                     pathVariable       : [String]?                     = nil,
                                                    urlParam           : Dictionary<String, String>?   = nil,
                                                     body               : I                             = "",
                                                     responseType       : O.Type                        = Download.self,
                                                     httpMethod         : HTTPMethod                    = .GET)  -> AnyPublisher<UploadResponse, Error> {
        
        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString
        
        let request = self.getURLRequest(baseURL        : baseURL,
                                         endpoint       : endpoint,
                                         pathVariable   : pathVariable,
                                         urlParam       : urlParam,
                                         body           : body,
                                         httpMethod     : httpMethod,
                                         contentType    : contentType,
                                         boundary       : boundary,
                                         rawURL         : rawURL)
        
        let task = NetworkManager.session.downloadTask(with: request)
        task.resume()
        return progress
            .receive(on: OperationQueue.main)
            .filter{ $0.id == task.taskIdentifier }
            .setFailureType(to: Error.self)
            .map { .progress(percentage: $0.progress) }
            .merge(with: subject)
            .eraseToAnyPublisher()
    }
    
    //MARK: - UploadTask - using with combine and response progress real time
    public func upload<I: Encodable, O: Decodable> (fileName        : String,
                                                    paramName       : String,
                                                    file            : Data,
                                                    baseURL         : String                        = APIKey.baseURL,
                                                    endpoint        : APIKey,
                                                    contentType     : ContentType                   = .FormData,
                                                    pathVariable    : [String]?                     = nil,
                                                    urlParam        : Dictionary<String, String>?   = nil,
                                                    body            : I                             = "",
                                                    responseType    : O.Type,
                                                    httpMethod      : HTTPMethod                    = .POST) -> AnyPublisher<UploadResponse, Error> {
        
        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString
        
        let request = self.getURLRequest(baseURL        : baseURL,
                                         endpoint       : endpoint,
                                         pathVariable   : pathVariable,
                                         urlParam       : urlParam,
                                         body           : body,
                                         httpMethod     : httpMethod,
                                         contentType    : contentType,
                                         boundary       : boundary)
        
        // get data request to upload
        let data = self.getDataRequest(fileName: fileName, paramName: paramName, file: file, boundary: boundary)
        
        let task: URLSessionUploadTask = NetworkManager.session.uploadTask(
            with: request,
            from: data
        ) { data, response, error in
            
            //MARK: - Check Data, Response Error
            guard let data = data else {
                
                let nsError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "error_occurred_during_process"])
#if DEBUG
                print("""
            \(nsError.code) | \(nsError.localizedDescription)
            """)
#endif
                
                return
            }
            
            let decodedDataString  = String(data: data, encoding: String.Encoding.utf8)?.removingPercentEncoding
            
            
            guard let responseData = decodedDataString == nil ? data : decodedDataString?.data(using: .utf8) else {
                let nsError = NSError(domain: "ClientError", code: 168, userInfo: [NSLocalizedDescriptionKey : "Could not convert string to data."])
                
#if DEBUG
                print("""
            \(nsError.code) | \(nsError.localizedDescription)
            """)
#endif
                return
            }
            
#if DEBUG
            Log("""
            \(request.url!) | \(endpoint.rawValue)
            \(responseData.prettyPrinted)
            """)
#endif
            
            guard let _ = try? JSONDecoder().decode(responseType, from: responseData) else {
                
                if responseData.prettyPrinted == "{\n\n}" {
                    print("Pretty Print nnnn")
                } else {
                    print("Response has no key error")
                }
                return
            }
            
            /// - subject sending data after upload completed
            self.subject.send(.response(data: data))
        }
        task.resume()
        return progress
            .receive(on: OperationQueue.main)
            .filter {
                $0.id == task.taskIdentifier
            }
            .setFailureType(to: Error.self)
            .map { .progress(percentage: $0.progress) }
            .merge(with: subject)
            .eraseToAnyPublisher()
    }
    
    //MARK: - GET REQUEST URL -
    private func getURLRequest<T: Encodable>(baseURL            : String,
                                             endpoint           : APIKey?                           = nil,
                                             pathVariable       : [String]?,
                                             urlParam           : Dictionary<String, String>?,
                                             body               : T,
                                             httpMethod         : HTTPMethod                        = .POST,
                                             contentType        : ContentType                       = .Json,
                                             boundary           : String?                           = nil,
                                             rawURL             : String?                           = nil)
    -> URLRequest {
        
        func queryString<T:Encodable>(body:T) -> String {
            let request     = body
            
            guard let str   = request.asJSONString() else { return "" }
            
            return str
        }
        
        var url : URL!
        
        if let rawURL = rawURL {
            url = URL(string: rawURL)
        } else {
            url = URL(string: "\(baseURL)\(endpoint!.rawValue)")
        }
        
        if let pathVariable = pathVariable {
            _ = pathVariable.map({ pathVariable in
                url.appendPathComponent(pathVariable)
            })
        }
        
        if let urlParam = urlParam {
            let queryItems = urlParam.map { (key: String, value: String) in
                return URLQueryItem(name: key, value: value)
            }
            if #available(iOS 16.0, *) {
                url.append(queryItems: queryItems)
            } else {
                // Fallback on earlier versions
            }
        }
        
        var request         = URLRequest(url: url!)
        request.httpMethod  = httpMethod.rawValue
        
        let strQuery = queryString(body: body)
        
        if httpMethod != .GET {
            request.httpBody = strQuery.data(using: .utf8)
        }
        
        guard let cookies = HTTPCookieStorage.shared.cookies(for: request.url!) else {
            return request
        }
        
        request.allHTTPHeaderFields = HTTPCookie.requestHeaderFields(with: cookies)
        
        switch contentType {
            
        case .Json:
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        case .FormData:
            request.addValue("multipart/form-data; boundary=\(boundary!)", forHTTPHeaderField: "Content-Type")
        }
        
        request.addValue("\(XAppVersion.base.rawValue)", forHTTPHeaderField: "X-App-Version")
        
        if let token = Shared.share.token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        Log.r("""
            Request: \(request)
            Header : \(String(describing: request.allHTTPHeaderFields))
            Method : \(String(describing: request.httpMethod))
            BODY   : \(strQuery)
            """)
        
        return request
    }
    
    //MARK: - GET REQUEST Data -
    private func getDataRequest(fileName    : String,
                                paramName   : String,
                                file        : Data,
                                boundary    : String) -> Data {
        
        var data = Data()
        
        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
        data.append(file)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        return data
    }
    
}

//MARK: - URLSessionDelegate -
extension NetworkManager : URLSessionDownloadDelegate, URLSessionTaskDelegate {
    
    public func urlSession(_ session: URLSession,
                           downloadTask: URLSessionDownloadTask,
                           didWriteData bytesWritten: Int64,
                           totalBytesWritten: Int64,
                           totalBytesExpectedToWrite: Int64) {
        let totalDownloaded = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        
        /// - subject sending download progress
        subject.send(.progress(percentage: totalDownloaded * 100))
    }
    
    public func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didSendBodyData bytesSent: Int64,
        totalBytesSent: Int64,
        totalBytesExpectedToSend: Int64
    ) {
        let totalDownloaded = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
        
        /// - subject sending upload progress
        subject.send(.progress(percentage: totalDownloaded * 100))
    }
    
    public func urlSession(_ session: URLSession,
                           downloadTask: URLSessionDownloadTask,
                           didFinishDownloadingTo location: URL) {
        
        //MARK: - Check Data, Response Error
        guard let data = try? Data(contentsOf: location) else {
            print("dat could not be loaded.")
            return
        }
        
        let decodedDataString  = String(data: data, encoding: String.Encoding.utf8)?.removingPercentEncoding
        
        
        guard let responseData = decodedDataString == nil ? data : decodedDataString?.data(using: .utf8) else {
            let nsError = NSError(domain: "ClientError", code: 168, userInfo: [NSLocalizedDescriptionKey : "Could not convert string to data."])
            
#if DEBUG
            print("""
        \(nsError.code) | \(nsError.localizedDescription)
        """)
#endif
            return
        }
        
#if DEBUG
        Log("""
        \(responseData.prettyPrinted)
        """)
#endif
        
        /// - subject sending data after download completed
        subject.send(.response(data: data))
    }
    
    public func urlSession(_: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            subject.send(completion: .failure(error))
        }
    }
}
