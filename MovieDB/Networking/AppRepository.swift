//
//  AppRepository.swift
//  Networking
//
//  Created by umair irfan on 04/07/2023.
//

import Foundation

open class AppRepository {
    
    public init() {
        
    }
    
    public lazy var movie: MovieServiceType = {
        return MovieService()
    }()
    
    public lazy var series: SeriesServiceType  = {
        return SeriesService()
    }()
}
