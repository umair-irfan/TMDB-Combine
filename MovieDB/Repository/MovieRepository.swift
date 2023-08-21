//
//  MovieRepository.swift
//  TMDB-Combine
//
//  Created by umair irfan on 20/07/2023.
//

import Combine

protocol MovieRepositoryType {
    func fetchMovies(with category: ModuleType) -> AnyPublisher<Module, NetworkError>
}

class MovieRepository: AppRepository, MovieRepositoryType, DetailRepositoryType {
    
    override init() {
        super.init()
    }
    
    func fetchMovies(with category: ModuleType) -> AnyPublisher<Module, NetworkError> {
        return movie.fetchMovies(with: category)
    }
}

// MARK: Mock Repository
class MockMovieRepository: AppRepository, MovieRepositoryType {
    
    override init() {
        super.init()
    }
    
    func fetchMovies(with category: ModuleType) -> AnyPublisher<Module, NetworkError> {
        Result.Publisher(Module.mockedData).eraseToAnyPublisher()
        // OR
        //        return Future<Movie, NetworkError> { promise in
        //            promise(.success(Movie.mockedData))
        //        }.eraseToAnyPublisher()
    }
}
