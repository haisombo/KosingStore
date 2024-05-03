//
//  LoginVM.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import Foundation
import Combine

class ViewModel  : ObservableObject {
    
    var iosMGData       : MGiOS.Response? = nil
    
    var aosMGData       : MGAOS.Response? = nil
    
    var loginData       : Login.Response? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    func requestiOSMG() -> Future<MGiOS.Response, Error> {
        let pathVariable    = [Shared.share.appId]
        let urlParam        : Dictionary<String, String> = ["os":"iOS"]
        return NetworkManager.shared.request(shouldShowLoading: false, baseURL: APIKey.mgURL.rawValue , pathVariable: pathVariable, urlParam: urlParam, endpoint: .mgURL, httpMethod: .GET, responseType: MGiOS.Response.self)
    }
    
    func requestAOSMG() -> Future<MGAOS.Response, Error> {
        let pathVariable    = [Shared.share.appId]
        let urlParam        : Dictionary<String, String> = ["os":"AOS"]
        return NetworkManager.shared.request(shouldShowLoading: false, baseURL: APIKey.mgURL.rawValue , pathVariable: pathVariable, urlParam: urlParam, endpoint: .mgURL  , httpMethod: .GET, responseType: MGAOS.Response.self)
    }
    
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
        completionHandler(.success(data))
    }
    .store(in: &cancellables)
    }
    
    
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
}
