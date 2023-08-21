//
//  HomeViewRouter.swift
//  MovieDB
//
//  Created by umair irfan on 09/08/2023.
//

import SwiftUI

class HomeCoordinator: AppCoordinator {
    
    enum Destination: Hashable {
        case ContentDetail(ProgramType)
    }
    
    var appRouter: AppRouter
    
    init(with appRouter: AppRouter) {
        self.appRouter = appRouter
    }
}

extension HomeView {
    
    func routes() -> some View {
        self.navigationDestination(for: HomeCoordinator.Destination.self) { destination in
            switch destination {
            case .ContentDetail(let type):
               DetailView(type)
            }
        }
    }
    
    @ViewBuilder
    func DetailView(_ type: ProgramType) -> some View {
        switch type {
        case .movies:
            let viewModel = ContentDetailViewModel(repo: MovieRepository())
            ContentDetailView(viewModel: viewModel)
        case .series:
            let viewModel = ContentDetailViewModel(repo: SeriesRrepository())
            ContentDetailView(viewModel: viewModel)
        }
    }
}


