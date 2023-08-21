//
//  RequestType.swift
//  APIClient
//
//  Created by umair irfan on 25/06/2023.
//

import Foundation

public enum RequestType: Int {
    case json
    case formData
}

public extension RequestType {
    var requestHeaders: [String: String] {
        var headers = [String: String]()
        switch self {
        case .json:
            headers["Content-Type"] = "application/json"
            headers["Accept"] = "application/json"
        case .formData:
            headers["Content-type"] = "multipart/form-data"
            headers["Accept"] = "application/json"
        }
        return headers
    }
}
