//
//  ModuleType.swift
//  MovieDB
//
//  Created by umair irfan on 08/08/2023.
//

import Foundation

public enum ProgramType {
    case movies
    case series
}

extension ProgramType {
    var rawValue: String {
        switch self {
        case .movies:
            return "Movies"
        case .series:
            return "TV Shows"
        }
    }
}

public enum LayoutOrientation {
    case backDrop
    case potrait
}

public enum ModuleType: Equatable, CaseIterable {
    public static var allCases: [ModuleType] = [.PlayingNow,
                                                .Popular(.movies),
                                                .TopRated(.movies),
                                                .Upcoming(.movies),
                                                .OnAirToday,
                                                .Popular(.series),
                                                .TopRated(.series),
                                                .OnAir]
    case PlayingNow
    case Popular(ProgramType)
    case TopRated(ProgramType)
    case Upcoming(ProgramType)
    case OnAirToday
    case OnAir
    case none
}

extension ModuleType {
    
    var rawValue: String {
        switch self {
        case .PlayingNow:
            return "now_playing"
        case .Popular:
            return "popular"
        case .TopRated:
            return "top_rated"
        case .Upcoming:
            return "upcoming"
        case .OnAirToday:
            return "airing_today"
        case .OnAir:
            return "on_the_air"
        case .none:
            return ""
        }
    }
    
    var orientation: LayoutOrientation {
        switch self {
        case .PlayingNow,  .Popular, .Upcoming, .OnAir, .OnAirToday:
            return .potrait
        case .TopRated:
            return .backDrop
        case .none:
            return .potrait
        }
    }
    
    var title: String {
        switch self {
        case .PlayingNow:
            return "Playing Now"
        case .Popular(let type):
            return "Popular " + type.rawValue
        case .TopRated(let type):
            return "Top " + type.rawValue
        case .Upcoming(let type):
            return "Up-Coming " + type.rawValue
        case .OnAirToday:
            return "Airing Today"
        case .OnAir:
            return "On Air"
        case .none:
            return ""
        }
    }
    
    var program: ProgramType {
        switch self {
        case .PlayingNow:
            return .movies
        case .Popular(let type), .TopRated(let type), .Upcoming(let type):
            return type
        case .OnAirToday, .OnAir:
            return .series
        case .none:
            return .movies
        }
    }
}
