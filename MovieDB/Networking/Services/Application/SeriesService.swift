//
//  SeriesService.swift
//  Networking
//
//  Created by umair irfan on 25/07/2023.
//

import Combine

public protocol SeriesServiceType {
    func fetchSeries<T: Decodable>(with category: ModuleType) -> AnyPublisher<T, NetworkError>
    func fetchDetail<T: Decodable>(with id: Int) -> AnyPublisher<T, NetworkError>
}

class SeriesService: NetworkService, SeriesServiceType {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient = WebClient()) {
        self.apiClient = apiClient
    }
}

extension SeriesService  {
    
    func fetchSeries<T: Decodable>(with category: ModuleType) -> AnyPublisher<T, NetworkError> {
        let querry: [String: String] = ["api_key": APIKey]
        
        let routerInput: RouterInput<[String: String]> = (body: nil, query: querry, pathVariables: [category.rawValue])
        let route = SeriesRouter.fetchSeries(routerInput)
        
        return request(apiClient: apiClient, route: route)
    }
    
    func fetchDetail<T: Decodable>(with id: Int) -> AnyPublisher<T, NetworkError> {
        let querry: [String: String] = ["api_key": APIKey, "language": "en-US"]
        let routerInput: RouterInput<[String: String]> = (body: nil, query: querry, pathVariables: ["\(id)"])
        let route =  SeriesRouter.fetchDetail(routerInput)
        
        return request(apiClient: apiClient, route: route)
    }
}
