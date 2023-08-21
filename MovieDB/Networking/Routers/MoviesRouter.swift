//
//  MoviesRouter.swift
//  Networking
//
//  Created by umair irfan on 27/06/2023.
//

import Foundation

enum MoviesRouter<T: Codable>: ClientRequestConvertible, Convertible {
    
    var authHeaders: [String : String] { [ : ] }
    
    case fetchMovies(RouterInput<T>)
    case fetchDetail(RouterInput<T>)
    
    // MARK: Properties
    
    private var method: ClientHTTPMethod {
        switch self {
        case .fetchMovies, .fetchDetail:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .fetchMovies, .fetchDetail:
            return "/3/movie/"
        }
    }
    
    private var input: RouterInput<T>? {
        switch self {
        case .fetchMovies(let input), .fetchDetail(let input):
            return input
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        return try urlRequest(path: path, method: method, input: input)
    }
}

