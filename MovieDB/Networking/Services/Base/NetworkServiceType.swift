//
//  NetworkServiceType.swift
//  Networking
//
//  Created by umair irfan on 13/07/2023.
//

import Combine
import Foundation

protocol NetworkServiceType {
    func request<T>(apiClient: APIClient, route: ClientRequestConvertible,
                    retries: Int, thread: RunLoop) -> AnyPublisher<T, NetworkError> where T: Decodable
    
    func upload<T: Codable>(apiClient: APIClient,
                            documents: [DocumentDataConvertible],
                            route: ClientRequestConvertible,
                            progressObserver: AnyObserver<Progress>?,
                            otherFormValues formValues: [String: String]) -> AnyPublisher<T, NetworkError>
}
