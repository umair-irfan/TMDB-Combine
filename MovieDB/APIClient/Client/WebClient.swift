//
//  WebClient.swift
//  APIClient
//
//  Created by umair irfan on 25/06/2023.
//
import Alamofire
import Combine
import Foundation

fileprivate typealias WebClientResponse = Future<APIResponseConvertible, NetworkError>

public class WebClient: APIClient {
    
    private var alamofire: Session
    
    private var urlSession: URLSession
    
    public init() {
        alamofire = ServerTrustPolicy.session
        urlSession = URLSession(configuration: .default)
    }
    
    public func request(route: ClientRequestConvertible) -> ClientResponse {
        
        guard Reachability.networkConection else {
            return Fail(error: NetworkError.noInternet).eraseToAnyPublisher()
        }
        
        guard let urlRequest = route.urlRequest else {
            return Fail(error: NetworkError.invalidRequest).eraseToAnyPublisher()
        }
        
        debug(urlRequest: urlRequest)
        
        return urlSession.dataTaskPublisher(for: urlRequest)
            .tryMap { (data, response) in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.unknown
                }
                self.debug(response: data)
                let apiResponse = APIResponse(code: httpResponse.statusCode, data: data)
                return apiResponse
            }
            .mapError { error in
                if let error = error as? NetworkError {
                    return error
                } else {
                    return NetworkError.serverError(error: error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
    
    public func execute(route: ClientRequestConvertible) -> ClientResponse {
        
        guard Reachability.networkConection else {
            return Fail(error: NetworkError.noInternet).eraseToAnyPublisher()
        }
        
        guard let urlRequest = route.urlRequest else {
            return Fail(error: NetworkError.invalidRequest).eraseToAnyPublisher()
        }
        
        debug(urlRequest: urlRequest)
        
        return WebClientResponse { promise in
            self.alamofire.request(route).validate().responseData(completionHandler: { [weak self] response in
                self?.debug(response: response)
                switch response.result {
                case .success(let data):
                    guard let code = response.response?.statusCode else {
                        promise(.failure(NetworkError.unknown))
                        return
                    }
                    let apiResponse = APIResponse(code: code, data: data)
                    promise(.success(apiResponse))
                case .failure:
                    if let code = response.response?.statusCode {
                        let err = NetworkErrorHandler.mapError(code, data: Data())
                        promise(.failure(err))
                    }
                    promise(.failure(.invalidResponse))
                }
            })
        }
        .eraseToAnyPublisher()
    }
    
    public func upload(documents: [DocumentDataConvertible],
                       route: ClientRequestConvertible,
                       progressObserver: AnyObserver<Progress>?,
                       otherFormValues formValues: [String: String]) -> ClientResponse {
        
        guard Reachability.networkConection  else {
            return Fail(error: NetworkError.noInternet).eraseToAnyPublisher()
        }
        
        let urlRequest = route.urlRequest
        
        debug(urlRequest: urlRequest)
        
        return Future<APIResponseConvertible, NetworkError> { [unowned self] promise in
            self.alamofire.upload(multipartFormData: { (multipartFormData) in
                _ = documents.map { multipartFormData.append($0.data,
                                                             withName: $0.name,
                                                             fileName: $0.fileName,
                                                             mimeType: $0.mimeType) }
                
                _ = formValues.map { multipartFormData.append($0.value.data(using: .utf8) ?? Data(),
                                                              withName: $0.key) }
            }, with: route).response { response in
                switch response.result {
                case .success(let data):
                    guard let code = response.response?.statusCode else { return }
                    guard let data else { return }
                    let apiResponse = APIResponse(code: code, data: data)
                    promise(.success(apiResponse))
                case .failure:
                    if let code = response.response?.statusCode {
                        let err = NetworkErrorHandler.mapError(code, data: Data())
                        promise(.failure(err))
                    }
                    promise(.failure(.invalidResponse))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

// MARK: Debug Extention
private extension WebClient {
    func debug(urlRequest: URLRequest?) {
        if let url = urlRequest?.url?.absoluteString {
            debugPrint(url + " -> REQUEST " + (String(data: urlRequest?.httpBody ?? Data(),
                                                      encoding: .utf8) ?? "Failed to Convert"))
        }
    }
    
    func debug(response: AFDataResponse<Data>) {
#if DEBUG
        response.data.map { String(data: $0, encoding: .utf8 ).map { debugPrint("Response:" + $0) } }
#endif
    }
    
    func debug(response: Data) {
#if DEBUG
        String(data: response, encoding: .utf8 ).map { print("Response:" + $0) }
#endif
    }
}
