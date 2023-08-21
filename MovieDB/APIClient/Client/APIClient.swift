//
//  APIClient.swift
//  APIClient
//
//  Created by umair irfan on 25/06/2023.
//
import Combine
import Alamofire
import Foundation

public typealias ClientRequestConvertible = URLRequestConvertible
public typealias ClientHTTPMethod = HTTPMethod
public typealias ClientResponse = AnyPublisher<APIResponseConvertible, NetworkError>

public protocol APIClient {
    
    func request(route: ClientRequestConvertible) -> ClientResponse
   
    func execute(route: ClientRequestConvertible) -> ClientResponse
    
    func upload(documents: [DocumentDataConvertible],
                route: ClientRequestConvertible,
                progressObserver: AnyObserver<Progress>?,
                otherFormValues formValues: [String: String]) -> ClientResponse
}
