//
//  ContentRowViewModel.swift
//  TMDB-Combine
//
//  Created by umair irfan on 25/07/2023.
//
import Foundation
import Combine

protocol ContentRowViewModelInput {
    
}

protocol ContentRowViewModelOutput {
    var title: String { get }
    //var imageUrl: URL { get }
    var contentId: CurrentValueSubject<Int, Never> { get }
}

protocol ContentRowViewModelType: ObservableObject, Identifiable {
    init(show: Program)
    var input: ContentRowViewModelInput { get }
    var output: ContentRowViewModelOutput { get }
    var id: UUID { get }
}


class ContentRowViewModel: ContentRowViewModelInput, ContentRowViewModelOutput, ContentRowViewModelType {
    
    var input: ContentRowViewModelInput { self }
    var output: ContentRowViewModelOutput { self }
    
    var id: UUID = UUID()
    private var show: Program
    //private var baseImageURL = "https://image.tmdb.org/t/p/original"
    
    @Published var title: String
    //@Published var imageUrl: URL
    var contentId = CurrentValueSubject<Int, Never>(0)
   
    
    required init(show: Program) {
        self.show  = show
        title = show.name
        contentId.send(show.id)
        //baseImageURL = baseImageURL + show.poster
        //imageUrl = URL(string: baseImageURL)!
    }
}
