//
//  DiscoverService.swift
//  Networking
//
//  Created by umair irfan on 18/07/2023.
//

import Combine

public protocol DiscoverServiceType {
    func fetchDiscovery<T: Decodable>(for category: ProgramType) -> AnyPublisher<T, NetworkError>
}

class DiscoverService: NetworkService, DiscoverServiceType {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient = WebClient()) {
        self.apiClient = apiClient
    }
}

extension DiscoverService {
    
    func fetchDiscovery<T: Decodable>(for category: ProgramType) -> AnyPublisher<T, NetworkError> {
        let querry: [String: String] = ["api_key": APIKey]
        
        let routerInput: RouterInput<[String: String]> = (body: nil, query: querry, pathVariables: ["discover/" + category.rawValue])
        let route = MoviesRouter.fetchMovies(routerInput)
        
        return request(apiClient: apiClient, route: route)
    }
}
