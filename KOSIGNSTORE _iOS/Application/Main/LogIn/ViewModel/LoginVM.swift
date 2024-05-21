//
//  LoginVM.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import Foundation
import Combine

class ViewModel  : ObservableObject {
    
    // MARK: - Property 
    @Published var iosMGData                   : MGiOS.Response? = nil
    @Published var aosMGData                   : MGAOS.Response? = nil
    @Published var loginData                   : Login.Response? = nil
    @Published var userID                      : Int? = 0
    @Published var companyID                   : Int? = 0
    @Published var userInfo                    : UserInfo?
    @Published var userType                    : UserType? = .Logout
    @Published var showAlert                   = false
    @Published private var cancellables        = Set<AnyCancellable>()
    
    
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
                    self?.userInfo = UserInfo(username: username, fullName: fullName, image: image, email: email, companyName: companyName)
                    Shared.userInfo = self?.userInfo
                    UserDefaults.standard.set(self?.userID, forKey: "USERID")
                    UserDefaults.standard.set(username, forKey: "USERNAME")
                    UserDefaults.standard.set(password, forKey: "PASSWORD")
                } else {
                    Shared.userType = .Logout
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

