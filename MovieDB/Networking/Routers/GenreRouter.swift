//
//  GenreRouter.swift
//  Networking
//
//  Created by umair irfan on 18/07/2023.
//

import Foundation

enum GenreRouter<T: Codable>: ClientRequestConvertible, Convertible {
    
    var authHeaders: [String : String] { [ : ] }
    
    case fetchGenre(RouterInput<T>)
    
    // MARK: Properties
    
    private var method: ClientHTTPMethod {
        switch self {
        case .fetchGenre:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .fetchGenre:
            return "/3/genre/"
        }
    }
    
    private var input: RouterInput<T>? {
        switch self {
        case .fetchGenre(let input):
            return input
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        return try urlRequest(path: path, method: method, input: input)
    }
}

