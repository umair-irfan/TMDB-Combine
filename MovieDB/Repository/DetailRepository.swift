//
//  DetailRepository.swift
//  MovieDB
//
//  Created by umair irfan on 15/08/2023.
//

import Foundation
import Combine

protocol DetailRepositoryType: class {
    func fetchDetail(with id: Int) -> AnyPublisher<Module, NetworkError>
}

extension DetailRepositoryType where Self: MovieRepository {
    func fetchDetail(with id: Int) -> AnyPublisher<Module, NetworkError> {
        movie.fetchDetail(with: id)
    }
}

extension DetailRepositoryType where Self: SeriesRrepository {
    func fetchDetail(with id: Int) -> AnyPublisher<Module, NetworkError> {
        series.fetchDetail(with: id)
    }
}
