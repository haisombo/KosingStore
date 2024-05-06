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
    @Published var isLoading        : Bool = false
    @Published var error            : Error?
    @Published var userType         : UserType? = .Logout
    private var cancellables        : Set<AnyCancellable> = []
    
    func getHomeData(userID: Int?, companyID: Int?) {
        isLoading = true
        let type: ListAppType = (userType == .Login) ? .Private : .Public
        
//        fetchListApp(userID: userID, companyID: companyID, type: type)
//            .receive(on: DispatchQueue.main)
//            .sink { completion in
//                self.isLoading = false
//                if case .failure(let error) = completion {
//                    self.error = error
//                }
//            } receiveValue: { response in
//                self.homeContentData = response?.data as! [HomeContentBody]
//            }
//            .store(in: &cancellables)
    }
    
    
    
//    private func fetchListApp(userID: Int?, companyID: Int?, type: ListAppType) -> AnyPublisher<ListApp.Response?, Error> {
//        let body: ListApp.Request?
//        switch type {
//        case .Public:
//            body = ListApp.Request(os_type: AnyCodableValue.string("ios"))
//        case .Private:
//            body = ListApp.Request(os_type: AnyCodableValue.string("ios"), user_id: AnyCodableValue.integer(userID ?? 0), company_id: AnyCodableValue.integer(companyID ?? 0))
//        }
//        let apiKey = (type == .Public) ? APIKey.listPublicApp : APIKey.listPrivateApp
//        
//        return NetworkManager.shared.request(endpoint: apiKey, httpMethod: .POST,body: body  , responseType: ListApp.Response.self)
//        
//            .mapError { $0 as Error }
////            .eraseToAnyPublisher()
//        
//    }
    
    
}
