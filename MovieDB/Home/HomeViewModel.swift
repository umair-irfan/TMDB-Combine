//
//  HomeViewModel.swift
//  TMDB-Combine
//
//  Created by umair irfan on 21/07/2023.
//

import Combine
import SwiftUI


protocol HomeViewModelInput {
    var onViewAppear: PassthroughSubject<Void, NetworkError> { get }
}

protocol HomeViewModelOutput {
    var isLoading: Bool { get }
    var titleSubject: CurrentValueSubject<String, Never> { get }
    var contentSections: CurrentValueSubject<[Layout], Never> { get }
}

protocol HomeViewModelType: ObservableObject {
    init(repo: HomeRepositoryType)
    var input: HomeViewModelInput { get }
    var output: HomeViewModelOutput { get }
}

class HomeViewModel: HomeViewModelInput, HomeViewModelOutput, HomeViewModelType  {
   
    var input: HomeViewModelInput { self }
    var output: HomeViewModelOutput { self }
    
    @Published var isLoading = true
   
    var onViewAppear = PassthroughSubject<Void, NetworkError>()
    var onNavigation =  PassthroughSubject<Void, NetworkError>()
    var titleSubject = CurrentValueSubject<String, Never>("Home")
    var contentSections =  CurrentValueSubject<[Layout], Never>([])
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let repo: HomeRepositoryType
    
    required init(repo: HomeRepositoryType) {
        self.repo = repo
        configureViewAppear()
    }
}


//MARK: Configure View-Model
extension HomeViewModel {
    func configureViewAppear() {
        onViewAppear
            .flatMap { [unowned self] _ in
                self.getAllContent()
            }.sink(
                receiveCompletion: { result in
                    self.isLoading = false
                    switch result {
                    case .failure(let error):
                        print(error)
                    default:
                        break
                    }
                },
                receiveValue: { [unowned self] sections in
                    self.isLoading = false
                    self.contentSections.send(sections)
                })
            .store(in: &subscriptions)
    }
}

//MARK: Fetch Data
private extension HomeViewModel {
    
    func getAllContent() -> AnyPublisher<[Layout], NetworkError> {
        Publishers.Zip(self.getContent(for: .movies),
                       self.getContent(for: .series)).map { movies, series in
            return movies + series
        }.eraseToAnyPublisher()
    }
    
    func getContent(for category: ProgramType) -> AnyPublisher<[Layout], NetworkError>  {
        switch category {
        case .movies:
            return Publishers.Zip4(repo.fetchMovies(with: .PlayingNow),
                                   repo.fetchMovies(with: .Popular(category)),
                                   repo.fetchMovies(with: .TopRated(category)),
                                   repo.fetchMovies(with: .Upcoming(category)))
            .map { [unowned self] in
                return self.prepareLayout(for: category, with: [$0,$1,$2,$3])
            }.eraseToAnyPublisher()
            
        case .series:
            return Publishers.Zip4(repo.fetchSeries(with: .OnAirToday),
                                   repo.fetchSeries(with: .Popular(category)),
                                   repo.fetchSeries(with: .TopRated(category)),
                                   repo.fetchSeries(with: .OnAir))
            .map { [unowned self] in
                return self.prepareLayout(for: category, with: [$0,$1,$2,$3])
            }.eraseToAnyPublisher()
        }
    }
}

//MARK: Prepare Layout
private extension HomeViewModel {
    
    func prepareLayout(for category: ProgramType, with modules: [Module]) -> [Layout] {
        let types = getModuleType(for: category)
        var layouts: [Layout] = []
        for (ind, mod) in modules.enumerated() {
            layouts.append(Layout(module: mod, title: types[ind].title, type: types[ind]))
        }
        return layouts.shuffled()
    }
    
    func getModuleType(for category: ProgramType) -> [ModuleType] {
        switch category {
        case .movies:
            return [.PlayingNow, .Popular(category),
                    .TopRated(category), .Upcoming(category)]
        case .series:
            return [.OnAirToday, .Popular(category),.TopRated(category), .OnAir]
        }
    }
}
