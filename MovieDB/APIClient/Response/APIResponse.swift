//
//  APIResponse.swift
//  APIClient
//
//  Created by umair irfan on 25/06/2023.
//

import Foundation

public protocol APIResponseConvertible: Codable {
    var code: Int { get }
    var data: Data { get }
}

public struct APIResponse: APIResponseConvertible {
    public let code: Int
    public let data: Data
    
    public init(code: Int, data: Data) {
        self.code = code
        self.data = data
    }
}
