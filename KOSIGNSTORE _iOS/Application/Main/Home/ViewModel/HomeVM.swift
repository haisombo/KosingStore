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
    @Published var logInVM                      = ViewModel()
    @Published var listAppVersionData          :  [AppDetailBody.VersionListInfo] = []
    @Published var homePublicApp                : ListAppVersion.Response? = nil
    @Published var listApp                      : ListApp.Response? = nil
    @Published var listStyleValue               = ""
    @Published var isLoading                    : Bool = false
    @Published var error                        : Error?
    @Published var userType                     : UserType? = .Logout
    @Published var sortListValue                = ""
    @Published var userID                       : Int? = 0
    @Published var companyID                    : Int? = 0
    @Published private   var cancellables       : Set<AnyCancellable> = []

    func search(text: String, completion: (Bool) -> ()) {
        let tempData = tempHomeContentData.filter({($0.appName?.lowercased().contains(text.lowercased())) ?? false})
        if tempData.isEmpty {
            completion(false)
        } else {
            homeContentData = tempData
            completion(true)
        }
    }
    
    // MARK: - get data and check type
    func getHomeData (completionHandler: @escaping () -> () = {} ) {
        let type : ListAppType = (userType == .Login) ? .Private : .Public
        fetchListApp(userID: self.userID , companyID: self.companyID , type: type  ) { result  in
            
            switch(result) {
            case .success(let data):
                
                guard let data = data else {return}
                let res = data
                if (res.status.booleanValue) {
                    let data = res.data
                    var versionListInfo : [AppDetailBody.VersionListInfo] = []
                    
                    for data in data {
                        if (data.dev != nil || data.real != nil) {
                            versionListInfo = [AppDetailBody.VersionListInfo(versionNumber: data.dev != nil ? data.dev?.versionNumber?.stringValue : data.real?.versionNumber?.stringValue, description: data.dev != nil ? data.dev?.description?.stringValue : data.real?.description?.stringValue,
                                                                             dev: data.dev == nil ? nil : AppDetailBody.VersionListInfo.AppEnvironment(
                                                                                modifiedDate: data.dev?.modifiedDate?.stringValue, filePath: data.dev?.filePath?.stringValue), real: data.real == nil ? nil : AppDetailBody.VersionListInfo.AppEnvironment(modifiedDate: data.real?.modifiedDate?.stringValue, filePath: data.real?.filePath?.stringValue))]
                            
                        }
                        self.homeContentData.append(HomeContentBody(id: data.id.intValue, companyName: data.appOfCompany?.stringValue, appName: data.name?.stringValue, appImage: data.icon?.stringValue, appVersion: AppDetailBody(id: data.id.intValue, companyName: data.appOfCompany?.stringValue, appName: data.name?.stringValue, appIcon: data.icon?.stringValue, appCreatedDate: data.appCreatedDate?.stringValue, appModifiedDate: data.appModifiedDate?.stringValue, isPublic: data.isPublic?.booleanValue, versionList: versionListInfo)))
                        
                        versionListInfo = []
                    }
                    self.homeContentDataSort = self.homeContentData
                    self.getSortListData() {
                        self.tempHomeContentData = self.homeContentData
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
        listStyleValue = (UserDefaults.standard.string(forKey: FilterSection.listStyle.rawValue) == nil ? FilterContentBody.RowType.LIST_APP_DETAIL.rawValue : UserDefaults.standard.string(forKey: FilterSection.listStyle.rawValue))!
        sortListValue = UserDefaults.standard.string(forKey: FilterSection.sortList.rawValue) == nil ? FilterContentBody.RowType.SORT_DATE.rawValue : UserDefaults.standard.string(forKey: FilterSection.sortList.rawValue)!
        
        guard let username = UserDefaults.standard.string(forKey: "USERNAME") else {
            completion()
            return
        }
        
        guard let password = UserDefaults.standard.string(forKey: "PASSWORD") else {
            completion()
            return
        }
        
        logInVM.requestLogin(username: username, password: password) { _ in
            completion()
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
