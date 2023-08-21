//
//  HomeRepository.swift
//  TMDB-Combine
//
//  Created by umair irfan on 21/07/2023.
//

import Combine

protocol HomeRepositoryType: MovieRepositoryType, SeriesRrepositoryType {
   
}

class HomeRepository: AppRepository, HomeRepositoryType {

    override init() {
        super.init()
    }
    
    func fetchMovies(with category: ModuleType) -> AnyPublisher<Module, NetworkError> {
        return movie.fetchMovies(with: category)
    }
    
    func fetchSeries(with category: ModuleType) -> AnyPublisher<Module, NetworkError> {
        return series.fetchSeries(with: category)
    }
}

// MARK: Mock Repository
class MockHomeRepository: AppRepository, HomeRepositoryType {
    
    override init() {
        super.init()
    }
    
    func fetchMovies(with category: ModuleType) -> AnyPublisher<Module, NetworkError> {
        Result.Publisher(Module.mockedData).eraseToAnyPublisher()
    }
    
    func fetchSeries(with category: ModuleType) -> AnyPublisher<Module, NetworkError> {
        Result.Publisher(Module.mockedData).eraseToAnyPublisher()
    }
    
    func fetchDetail(with id: Int) -> AnyPublisher<Module, NetworkError> {
        Result.Publisher(Module.mockedData).eraseToAnyPublisher()
    }
}
