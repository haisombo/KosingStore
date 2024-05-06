//
//  HomeVM.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var homeContentData  : [HomeContentBody] = []
    @Published var homePublicApp    : ListAppVersion.Response? = nil
    @Published var listApp          : ListApp.Response? = nil
    
    @Published var isLoading        : Bool = false
    @Published var error            : Error?
    @Published var userType         : UserType? = .Logout
    private var cancellables        : Set<AnyCancellable> = []
    

    
    func  fetchListApp  (userID: Int?, companyID: Int?, type: ListAppType , completionHandler: @escaping (Swift.Result<ListApp.Response?, Error>) -> Void ) {
        let body = ListApp.Request(os_type: AnyCodableValue.string("ios"))
        NetworkManager.shared.request(endpoint:  APIKey.listPublicApp , httpMethod: .POST, body: body, responseType: ListApp.Response.self)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    completionHandler(.failure(error))
                case .finished: break
                }
            }
    receiveValue: { [weak self] data in
        self?.listApp = data
        completionHandler(.success(data))
    }
    .store(in: &cancellables)
        
    }
    
    
    // MARK: - Public Version by id
    func  fetchListPublicAppVersion (id : Int ,  completionHandler: @escaping (Swift.Result<ListAppVersion.Response?, Error>) -> Void ) {
        let body = ListAppVersion.Request(app_id: AnyCodableValue.integer(id), os_type: AnyCodableValue.string("ios"))
        
        NetworkManager.shared.request(endpoint:  APIKey.listPublicAppVersion , httpMethod: .POST, body: body, responseType: ListAppVersion.Response.self)
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

}
