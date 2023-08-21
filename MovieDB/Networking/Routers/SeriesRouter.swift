//
//  SeriesRouter.swift
//  Networking
//
//  Created by umair irfan on 25/07/2023.
//

import Foundation

enum SeriesRouter<T: Codable>: ClientRequestConvertible, Convertible {
    
    var authHeaders: [String : String] { [ : ] }
    
    case fetchSeries(RouterInput<T>)
    case fetchDetail(RouterInput<T>)
    
    // MARK: Properties
    
    private var method: ClientHTTPMethod {
        switch self {
        case .fetchSeries, .fetchDetail:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .fetchSeries, .fetchDetail:
            return "/3/tv/"
        }
    }
    
    private var input: RouterInput<T>? {
        switch self {
        case .fetchSeries(let input), .fetchDetail(let input):
            return input
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        return try urlRequest(path: path, method: method, input: input)
    }
}

