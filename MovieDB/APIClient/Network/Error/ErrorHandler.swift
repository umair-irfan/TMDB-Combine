//
//  ErrorHandler.swift
//  APIClient
//
//  Created by umair irfan on 25/06/2023.
//

import Foundation

open class NetworkErrorHandler {
    
    public static func mapError(_ code: Int, data: Data) -> NetworkError {
        switch code {
        case 401:
            let authError: AuthError? = try? decode(data: data)
            return .authError(authError)
        case 403:
            return .forbidden
        case 404:
            return .notFound
        case 400...499:
            let serverErrors: InternalServerError? = try? decode(data: data)
            return .internalServerError(serverErrors)
        case 502:
            return .badGateway
        case -1009:
            return .noInternet
        case -1001:
            return .requestTimedOut
        default:
            return .unknown
        }
    }
}

private extension NetworkErrorHandler {
    static func decode<T: Codable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
