//
//  CurrencyService.swift
//  Networking
//
//  Created by umair irfan on 27/06/2023.
//
import Combine


public protocol MovieServiceType {
    func fetchMovies<T: Decodable>(with category: ModuleType) -> AnyPublisher<T, NetworkError>
    func fetchDetail<T: Decodable>(with id: Int) -> AnyPublisher<T, NetworkError>
}

class MovieService: NetworkService, MovieServiceType {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient = WebClient()) {
        self.apiClient = apiClient
    }
}

extension MovieService {
    
    func fetchMovies<T: Decodable>(with category: ModuleType) -> AnyPublisher<T, NetworkError> {
        let querry: [String: String] = ["api_key": APIKey, "language": "en-US"]
        
        let routerInput: RouterInput<[String: String]> = (body: nil, query: querry, pathVariables: [category.rawValue])
        let route = MoviesRouter.fetchMovies(routerInput)
        
        return request(apiClient: apiClient, route: route)
    }
    
    func fetchDetail<T: Decodable>(with id: Int) -> AnyPublisher<T, NetworkError> {
        let querry: [String: String] = ["api_key": APIKey, "language": "en-US"]
        let routerInput: RouterInput<[String: String]> = (body: nil, query: querry, pathVariables: ["\(id)"])
        let route = MoviesRouter.fetchDetail(routerInput)
        
        return request(apiClient: apiClient, route: route)
    }
}
