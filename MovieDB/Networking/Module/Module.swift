//
//  Movie.swift
//  Networking
//
//  Created by umair irfan on 04/07/2023.
//

import Foundation

public struct Module {
    let page: Int
    public let content: [Program]
    let totalPages: Int
    let totalResults: Int
}

extension Module: Codable {
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case content = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        content = try container.decode([Program].self, forKey: .content)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        totalResults = try container.decode(Int.self, forKey: .totalResults)
    }
}

//MARK: - MOCK Module
public extension Module {
    static var mockedData: Module {
        do {
            let response: Module? = try? Bundle.main.decodeStubJSON(from: "movie_list")
            guard let response else { throw NetworkError.invalidResponse }
            return response
        } catch let error {
            print(error.localizedDescription)
        }
        return Module(page: 1, content: [Program.mocked], totalPages: 10, totalResults: 655)
    }
}
