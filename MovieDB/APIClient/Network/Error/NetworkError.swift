//
//  NetworkError.swift
//  APIClient
//
//  Created by umair irfan on 25/06/2023.
//

import Foundation

public enum NetworkError: LocalizedError {
    case noInternet
    case requestTimedOut
    case badGateway
    case notFound
    case forbidden
    case internalServerError(InternalServerError?)
    case serverError(Int, String)
    case authError(AuthError?)
    case unknown
    case invalidResponse
    case invalidRequest
    case serverError(error: String)
}

public struct ServerError: Codable {
    public let code: String
    public let message: String
}

public struct InternalServerError: Codable {
    public let errors: [ServerError]
}

public struct AuthError: Codable {
    public struct AuthErrorDetail: Codable {
        public let code: String
        public let message: String
    }
    public let error: AuthErrorDetail
}
