//
//  Program.swift
//  MovieDB
//
//  Created by umair irfan on 08/08/2023.
//

import Foundation

public struct Program {
    public let id: Int
    public let name: String
    public let originalName: String
    public let poster: String
    private let backdrop: String
    let overview: String
    let popularity: Double
    let voteAverage: Double
    let voteCount: Int
}

extension Program: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id, overview, popularity
        case originalName = "name"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case name = "title"
        case poster = "poster_path"
        case backdrop = "backdrop_path"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        originalName = try container.decodeIfPresent(String.self, forKey: .originalName) ?? ""
        overview = try container.decode(String.self, forKey: .overview)
        popularity = try container.decode(Double.self, forKey: .popularity)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        voteCount = try container.decode(Int.self, forKey: .voteCount)
        poster = try container.decode(String.self, forKey: .poster)
        backdrop = try container.decodeIfPresent(String.self, forKey: .backdrop) ?? ""
    }
    
    public var posterURL: URL {
        return URL(string: PosterPath + poster)!
    }
    
    public var backdropURL: URL {
        return URL(string: BackdropPath + backdrop)!
    }
    
    static let mocked = Program(id: 1, name: "Bloodshot", originalName: "Bloodshot", poster: "/8WUVHemHFH2ZIP6NWkwlHWsyrEL.jpg", backdrop: "/ocUrMYbdjknu2TwzMHKT9PBBQRw.jpg", overview: "After he and his wife are murdered, marine Ray Garrison is resurrected by a team of scientists. Enhanced with nanotechnology, he becomes a superhuman, biotech killing machine—'Bloodshot'. As Ray first trains with fellow super-soldiers, he cannot recall anything from his former life. But when his memories flood back and he remembers the man that killed both him and his wife, he breaks out of the facility to get revenge, only to discover that there's more to the conspiracy than he thought.", popularity: 160, voteAverage: 7.1, voteCount: 2324)
}
