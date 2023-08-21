//
//  ContentDetailViewModel.swift
//  TMDB-Combine
//
//  Created by umair irfan on 27/07/2023.
//

import Combine

protocol ContentDetailViewModelInput {
    var contentId: CurrentValueSubject<Int, Never> { get }
}

protocol ContentDetailViewModelOutput {
    
}

protocol ContentDetailViewModelType: ObservableObject {
    init(repo: DetailRepositoryType)
    var input: ContentDetailViewModelInput { get }
    var output: ContentDetailViewModelOutput { get }
}

class ContentDetailViewModel: ContentDetailViewModelInput, ContentDetailViewModelOutput, ContentDetailViewModelType {
    
    var input: ContentDetailViewModelInput { self }
    var output: ContentDetailViewModelOutput { self }
    // 569094
    var contentId = CurrentValueSubject<Int, Never>(215315)
    
    private var repo: DetailRepositoryType
    private var subscriptions = Set<AnyCancellable>()
    
    required init(repo: DetailRepositoryType) {
        self.repo = repo
        loadView()
    }
    
    func loadView(){
        let result = repo.fetchDetail(with: contentId.value)
        result.sink { completion in
            switch completion {
            case .failure(let error):
                print (error)
            default:
                break
                
            }
        } receiveValue: { content in
            print(content)
        }.store(in: &subscriptions)
    }
}
