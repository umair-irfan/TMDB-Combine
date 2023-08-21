//
//  SeriesRrepository.swift
//  TMDB-Combine
//
//  Created by umair irfan on 25/07/2023.
//

import Combine

protocol SeriesRrepositoryType {
    func fetchSeries(with category: ModuleType) -> AnyPublisher<Module, NetworkError>
}

class SeriesRrepository: AppRepository, SeriesRrepositoryType, DetailRepositoryType {
    
    override init() {
        super.init()
    }
    
    func fetchSeries(with category: ModuleType) -> AnyPublisher<Module, NetworkError> {
        return series.fetchSeries(with: category)
    }
}

// MARK: Mock Repository
class MockSeriesRrepository: AppRepository, SeriesRrepositoryType {
    
    override init() {
        super.init()
    }
    
    func fetchSeries(with category: ModuleType) -> AnyPublisher<Module, NetworkError> {
        Result.Publisher(Module.mockedData).eraseToAnyPublisher()
    }
}
