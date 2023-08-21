//
//  RequestConvertible.swift
//  APIClient
//
//  Created by umair irfan on 25/06/2023.
//

import Foundation

public typealias RouterInput<T> = (body: T?, query: [String: String]?, pathVariables: [String]?)

public protocol Convertible {
    
    var authHeaders: [String: String] { get }
    
    func urlRequest<T: Codable>(with url: URL, path: String, method: ClientHTTPMethod,
                                requestType: RequestType,input: RouterInput<T>?) throws -> URLRequest
    
}

public extension Convertible {
    
    func urlRequest<T: Codable>(with url: URL = BaseURL, path: String, method: ClientHTTPMethod,
                                requestType: RequestType = .json, input: RouterInput<T>?) throws -> URLRequest {

        let url = try constructAPIUrl(with: url, path: path, input: input)
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        
        let requestTypeHeaders = requestType.requestHeaders
        for (key, value) in requestTypeHeaders {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        for (key, value) in authHeaders {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        if let parameters = input?.body {
            urlRequest.httpBody = Data()
            do {
                let encoder = JSONEncoder()
                encoder.dateEncodingStrategy = .millisecondsSince1970
                urlRequest.httpBody = try encoder.encode(parameters)
            } catch {
                throw error
            }
        }

        return urlRequest
    }
}

// MARK: Construct URL
private extension Convertible {
    
    func constructAPIUrl<T: Codable>(with url: URL, path: String, input: RouterInput<T>?) throws -> URL {
        
        guard let `input` = input else { return url.appendingPathComponent(path) }
        
        var constructedURL = url.appendingPathComponent(path)
        
        if let pathVariables = input.pathVariables {
            for pathVariable in pathVariables {
                constructedURL.appendPathComponent(pathVariable)
            }
        }

        if let query = input.query {
            var components = URLComponents(string: constructedURL.absoluteString)!
            var queryItems = [URLQueryItem]()
            for (key, value) in query {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
            components.queryItems = queryItems
            return components.url!
        }
        
        return constructedURL
    }
}
