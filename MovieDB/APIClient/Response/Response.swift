//
//  Response.swift
//  APIClient
//
//  Created by umair irfan on 25/06/2023.
//

import Foundation


// MARK: Custom Decodable response
public struct Response<T: Decodable>: Decodable {
    public let result: T
    public let serverErrors: [ServerError]?
}

extension Response {
    private enum CodingKeys: String, CodingKey {
        case result = "data"
        case serverErrors = "errors"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decode(T.self, forKey: .result)
        serverErrors = try values.decode([ServerError]?.self, forKey: .serverErrors)
    }
}
