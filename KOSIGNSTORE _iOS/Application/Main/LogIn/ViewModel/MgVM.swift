//
//  MgVM.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/3/24.
//

import Foundation
import Combine

class MgVM : ObservableObject  {
    
    var data : MG.Response?
    private var cancellables = Set<AnyCancellable>()
    
    func  requestMG (completionHandler: @escaping (Swift.Result<MG.Response?, Error>) -> Void) {
        NetworkManager.shared.request(endpoint: .mgURL  , httpMethod: .GET, responseType: MG.Response.self)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    
                    completionHandler(.failure(error))
                    
                case .finished: break
                }
            }
    receiveValue: { [weak self] data in
        self?.data = data
        completionHandler(.success(data))
    }
    .store(in: &cancellables)
    }
    
}
