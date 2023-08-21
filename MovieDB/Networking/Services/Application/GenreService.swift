//
//  GenreService.swift
//  Networking
//
//  Created by umair irfan on 18/07/2023.
//

import Combine

public protocol GenreServiceType {
    func fetchGenre<T: Decodable>(for category: ProgramType) -> AnyPublisher<T, NetworkError>
}

class GenreService: NetworkService, GenreServiceType {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient = WebClient()) {
        self.apiClient = apiClient
    }
}

extension GenreService {
    
    func fetchGenre<T: Decodable>(for category: ProgramType) -> AnyPublisher<T, NetworkError> {
        let querry: [String: String] = ["api_key": APIKey]
        
        let routerInput: RouterInput<[String: String]> = (body: nil, query: querry, pathVariables: [category.rawValue + "/list"])
        let route = MoviesRouter.fetchMovies(routerInput)
        
        return request(apiClient: apiClient, route: route)
    }
}
