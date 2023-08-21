//
//  HomeView.swift
//  TMDB-Combine
//
//  Created by umair irfan on 20/07/2023.
//
import SwiftUI

struct HomeView<VM: HomeViewModelType>: View {
    
    @StateObject var viewModel: VM
    private var coordinator: HomeCoordinator
    
    init(viewModel: VM, coordinator: HomeCoordinator) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.coordinator = coordinator
    }
    
    var body: some View {
        LoadingView(isShowing: .constant(viewModel.output.isLoading)) {
            ScrollView(.vertical, showsIndicators: false) {
                homeLayout()
            }
            .padding(.all, 10)
        }.onAppear {
            viewModel.input.onViewAppear.send()
        }
    }
    
    @ViewBuilder
    func homeLayout() -> some View {
        SectionListView(sections: viewModel.output.contentSections.value) { section in
            SectionItemView(section: section) { program in
                makeLayout(for: section.type.orientation,
                           with: program).onTapGesture {
                    let destination = HomeCoordinator.Destination.ContentDetail(section.type.program)
                    coordinator.push(to: destination)
                }
            }
        }
    }
    
    @ViewBuilder
    func makeLayout(for orientation: LayoutOrientation, with content: Program) -> some View {
        switch orientation {
        case .backDrop:
            BackdropCarousel(show: content)
        case .potrait:
            ContentRowView(show: content)
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HomeViewModel(repo: MockHomeRepository())
        HomeView(viewModel: viewModel, coordinator: HomeCoordinator(with: AppRouter()))
    }
}
