//
//  RootView.swift
//  TMDB-Combine
//
//  Created by umair irfan on 20/07/2023.
//

import SwiftUI

struct RootView<VM: RootViewModelType>: View {
    
    @StateObject var viewModel: VM
    @ObservedObject var router = AppRouter()
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        TabView {
            ForEach(viewModel.output.tabBarItems.value, id: \.id) { item in
                setupTabBar(with: item)
            }
        }
    }
}

// MARK: View Setup
private extension RootView {
    
    @ViewBuilder
    func setupTabBar(with item: TabBarItems) -> some View {
        switch item.index {
        case 0:
            HomeViewTab(item)
        case 1:
            MovieView()
                .tabItem {
                    Label(item.title, systemImage: "popcorn").foregroundColor(.white)
                }
        case 2:
            SeriesView()
                .tabItem {
                    Label(item.title, systemImage: "tv")
                }
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    func HomeViewTab(_ item: TabBarItems) -> some View {
        NavigationStack(path: $router.navPath) {
            HomeView(viewModel: HomeViewModel(repo: HomeRepository()),
                     coordinator: HomeCoordinator(with: router)).routes()
        }
        .environmentObject(router)
        .tabItem { Label(item.title, systemImage: "house") }.tint(.white)
        
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewModel: RootViewModel())
    }
}
