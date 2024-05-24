//
//  HomeVM.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var homeContentData              : [HomeContentBody] = []
    @Published var homeContentDataSort          : [HomeContentBody] = []
    @Published var tempHomeContentData          : [HomeContentBody] = []
    @Published var listAppVersionData          :  [AppDetailBody.VersionListInfo] = []
    @Published var homePublicApp                : ListAppVersion.Response? = nil
    @Published var tempListAppData              : ListApp.Response? = nil
    @Published var listApp                      : ListApp.Response? = nil
    @Published var listStyleValue               = ""
    @Published var isLoading                    : Bool = false
    @Published var error                        : Error?
    @Published var userType                     : UserType? = .Logout
    @Published var sortListValue                = ""
    @Published var userID                       : Int? = UserDefaults.standard.integer(forKey: "USERID")
    @Published var companyID                    : Int? = UserDefaults.standard.integer(forKey: "COMPANYID")
    @Published var isLogin                      :Bool = false
    @Published private   var cancellables       : Set<AnyCancellable> = []
    // MARK: - Property
    @Published var iosMGData                   : MGiOS.Response? = nil
    @Published var aosMGData                   : MGAOS.Response? = nil
    @Published var loginData                   : Login.Response? = nil
    @Published var userInfo                    = UserInfo()
    @Published var showAlert                   = false
    
    @Published var searchText: String = "" {
           didSet {
               filterApps()
           }
       }
    
    func filterApps() {
        if searchText.isEmpty {
            listApp?.data = tempListAppData?.data ?? []
        } else {
            listApp?.data = tempListAppData?.data.filter {
                ($0.name?.stringValue.lowercased().contains(searchText.lowercased())) ?? false
            } ?? []
        }
    }
    



    func getHomeData (completionHandler: @escaping () -> () = {} ) {
        let type : ListAppType = (userType == .Login) ? .Private : .Public
        fetchListApp(userID: self.userID , companyID: self.companyID , type: type  ) { result  in
            
            switch(result) {
            case .success(let data):
                
                guard let data = data else {return}
                let res = data
                if (res.status.booleanValue) {
                    let data = res.data
//                    var versionListInfo : [AppDetailBody.VersionListInfo] = []
                    self.tempListAppData = res
                    self.listApp = res
//                    self.homeContentDataSort = self.homeContentData
//                    for data in data {
//                        if (data.dev != nil || data.real != nil) {
//                            versionListInfo = [AppDetailBody.VersionListInfo(versionNumber: data.dev != nil ? data.dev?.versionNumber?.stringValue : data.real?.versionNumber?.stringValue, description: data.dev != nil ? data.dev?.description?.stringValue : data.real?.description?.stringValue,
//                                                                             dev: data.dev == nil ? nil : AppDetailBody.VersionListInfo.AppEnvironment(
//                                                                                modifiedDate: data.dev?.modifiedDate?.stringValue, filePath: data.dev?.filePath?.stringValue), real: data.real == nil ? nil : AppDetailBody.VersionListInfo.AppEnvironment(modifiedDate: data.real?.modifiedDate?.stringValue, filePath: data.real?.filePath?.stringValue))]
//                            
//                        }
//                        self.homeContentData.append(HomeContentBody(id: data.id.intValue, companyName: data.appOfCompany?.stringValue, appName: data.name?.stringValue, appImage: data.icon?.stringValue, appVersion: AppDetailBody(id: data.id.intValue, companyName: data.appOfCompany?.stringValue, appName: data.name?.stringValue, appIcon: data.icon?.stringValue, appCreatedDate: data.appCreatedDate?.stringValue, appModifiedDate: data.appModifiedDate?.stringValue, isPublic: data.isPublic?.booleanValue, versionList: versionListInfo)))
//                        
//                        versionListInfo = []
//                    }
                    self.homeContentDataSort = self.homeContentData
                    self.getSortListData() {
//                        self.tempHomeContentData = self.homeContent Data
                        self.tempListAppData    = self.listApp
                        completionHandler()
                    }
                }
                
            case .failure(let error ):
                print(error.localizedDescription)
                completionHandler()
            }
        }
    }
    

    // MARK: - Filter Data sort by name App
    func getSortListData(completion: () -> ()) {
        if self.sortListValue == FilterContentBody.RowType.SORT_APP_NAME.rawValue {
            self.homeContentData.sort(by: {$0.appName!.lowercased() < $1.appName!.lowercased()})
        } else {
            self.homeContentData = homeContentDataSort
        }
        completion()
    }
    
    // MARK: - Save Data to UserDefault
    func checkUserDefault(completion: @escaping () -> () = {}) {
  
//        guard let username = UserDefaults.standard.string(forKey: "USERNAME") else {
//            completion()
//            return
//        }
//        
//        guard let password = UserDefaults.standard.string(forKey: "PASSWORD") else {
//            completion()
//            return
//        }
        guard let username = UserDefaults.standard.string(forKey: "USERNAME"),
                    let password = UserDefaults.standard.string(forKey: "PASSWORD") else {
                  completion()
                  return
              }
              
        requestLogin(username: username, password: password) { _ in
            completion()
            self.isLogin = true
        }
    }
    
    // MARK: - Fetch Data list App
    func  fetchListApp  (userID: Int?, companyID: Int?, type: ListAppType , completionHandler: @escaping (Swift.Result<ListApp.Response?, Error>) -> Void ) {
        let body : ListApp.Request
        switch type {
        case .Public :
            body = ListApp.Request(os_type: AnyCodableValue.string("ios"))
        case .Private :
            body =  ListApp.Request(os_type: AnyCodableValue.string("ios"), user_id: AnyCodableValue.integer(userID ?? 0), company_id: AnyCodableValue.integer(companyID ?? 0))
        }
        let apiKey = (type == .Public) ? APIKey.listPublicApp : APIKey.listPrivateApp
        NetworkManager.shared.request(endpoint:  apiKey  , httpMethod: .POST, body: body, responseType: ListApp.Response.self)
        
            .sink { completion in
                switch completion {
                case .failure(let error):
                    completionHandler(.failure(error))
                case .finished: break
                }
            }
    receiveValue: { [weak self] data in
        self?.tempListAppData = data
//        self?.listApp = data
        completionHandler(.success(data))
    }
    .store(in: &cancellables)
    }
    
    
    // MARK: - Public Version by id
//    func  fetchListPublicAppVersion (id : Int ,  completionHandler: @escaping (Swift.Result<ListAppVersion.Response?, Error>) -> Void ) {
//        let body = ListAppVersion.Request(app_id: AnyCodableValue.integer(id), os_type: AnyCodableValue.string("ios"))
//        
//        NetworkManager.shared.request(endpoint:  APIKey.listPublicAppVersion , httpMethod: .POST, body: body, responseType: ListAppVersion.Response.self)
//            
//            .sink { completion in
//                switch completion {
//                case .failure(let error):
//                    completionHandler(.failure(error))
//                case .finished: break
//                }
//            }
//    receiveValue: { [weak self] data in
//        self?.homePublicApp = data
//        completionHandler(.success(data))
//    }
//    .store(in: &cancellables)
//    }
    
    // MARK: - Private Version by id
    func  fetchListPrivateAppVersion (id : Int ,  completionHandler: @escaping (Swift.Result<ListAppVersion.Response?, Error>) -> Void ) {
        let body = ListAppVersion.Request(app_id: AnyCodableValue.integer(id), os_type: AnyCodableValue.string("ios"))
        
        NetworkManager.shared.request(endpoint:  APIKey.listPrivateAppVersion , httpMethod: .POST, body: body, responseType: ListAppVersion.Response.self)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    
                    completionHandler(.failure(error))
                case .finished: break
                }
            }
        
    receiveValue: { [weak self] data in
        self?.homePublicApp = data
        completionHandler(.success(data))
    }
    .store(in: &cancellables)
    }
    
    // MARK: - Requesr iOS MG
    func requestiOSMG() -> Future<MGiOS.Response, Error> {
        let pathVariable    = [Shared.share.appId]
        let urlParam        : Dictionary<String, String> = ["os":"iOS"]
        return NetworkManager.shared.request(shouldShowLoading: false, baseURL: APIKey.mgURL.rawValue , pathVariable: pathVariable, urlParam: urlParam, endpoint: .mgURL, httpMethod: .GET, responseType: MGiOS.Response.self)
    }
    // MARK: - Requesr AOS MG
    func requestAOSMG() -> Future<MGAOS.Response, Error> {
        let pathVariable    = [Shared.share.appId]
        let urlParam        : Dictionary<String, String> = ["os":"AOS"]
        return NetworkManager.shared.request(shouldShowLoading: false, baseURL: APIKey.mgURL.rawValue , pathVariable: pathVariable, urlParam: urlParam, endpoint: .mgURL  , httpMethod: .GET, responseType: MGAOS.Response.self)
    }
    
    // MARK: - Request Login
    func requestLogin(username: String, password: String, completionHandler: @escaping (Swift.Result<Login.Response?, Error>) -> Void) {
        let body = Login.Request(username: AnyCodableValue.string(username), password: AnyCodableValue.string(password))
        NetworkManager.shared.request(endpoint: .login, httpMethod: .POST, body: body, responseType: Login.Response.self)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    completionHandler(.failure(error))
                case .finished: break
                }
            }
    receiveValue: { [weak self] data in
                self?.loginData = data
        //        guard let data = data else {return}
                if data.status.booleanValue {
                    Shared.userType = .Login
                    self?.userID = data.data?.id?.intValue
                    self?.companyID = data.data?.listCompany?.first?.id?.intValue
                    let username = data.data?.username?.stringValue
                    let fullName = data.data?.fullName?.stringValue
                    let email = data.data?.email?.stringValue
                    let image = data.data?.profile?.stringValue
                    let companyName = data.data?.listCompany?.first?.name?.stringValue
                    let token = data.data?.token?.stringValue
                    Shared.share.token = token
//                    self.userInfo = UserInfo(username: username, fullName: fullName, image: image, email: email, companyName: companyName)
                    Shared.userInfo = UserInfo(username: username ?? "", fullName: fullName ?? "", image: image ?? "", email: email ?? "", companyName: companyName)
                    UserDefaults.standard.set(true, forKey: "login")
                    UserDefaults.standard.set(self?.userID, forKey: "USERID")
                    UserDefaults.standard.set(self?.companyID, forKey: "COMPANYID")
                    UserDefaults.standard.set(username, forKey: "USERNAME")
                    UserDefaults.standard.set(password, forKey: "PASSWORD")
                } else {
                    Shared.userType = .Logout
                    UserDefaults.standard.set(true, forKey: "logout")
                    UserDefaults.standard.removeObject(forKey: "USERID")
                    UserDefaults.standard.removeObject(forKey: "USERNAME")
                    UserDefaults.standard.removeObject(forKey: "PASSWORD")
                }
        completionHandler(.success(data))
    }
    .store(in: &cancellables)
    }
    
    // MARK: - Request Both Version
    func requestiOSAndiOSMG() {
        Publishers.Zip(requestiOSMG(), requestAOSMG())
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let err):
                    
                    print("""
                                   😵❌ Error is ⚠️ \(err.localizedDescription) ⚠️
                                   """)
                    
                case .finished:
                    print("""
                                🎉🤩
                                ===> Fetch Sucess ✅ 👏🥳
                                🎉🤩
                      """)
                }
            }
    receiveValue: { [weak self] data in
        self?.iosMGData = data.0
        self?.aosMGData = data.1
    }
    .store(in: &cancellables)
    }
    // MARK: - Handle request and then set to true to show the alert
    func buttonTapped() {
            self.showAlert = true
    }
}
