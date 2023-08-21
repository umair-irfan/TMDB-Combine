//
//  RootViewModel.swift
//  TMDB-Combine
//
//  Created by umair irfan on 20/07/2023.
//

import Combine
import Foundation

struct TabBarItems: Identifiable {
    var id: UUID = UUID()
    var title: String
    var index: Int
    
    init(title: String, index: Int) {
        self.title = title
        self.index = index
    }
    
    static var allItems = [TabBarItems(title: "Home", index: 0),
                           TabBarItems(title: "Movie", index: 1),
                           TabBarItems(title: "Series", index: 2)]
}

protocol RootViewModelInput {
    
}

protocol RootViewModelOutput {
    var tabBarItems: CurrentValueSubject<[TabBarItems], Never> { get }
}

protocol RootViewModelType: ObservableObject {
    init ()
    var input: RootViewModelInput { get }
    var output: RootViewModelOutput { get }
}

class RootViewModel: RootViewModelInput, RootViewModelOutput, RootViewModelType {
    
    var input: RootViewModelInput { self }
    var output: RootViewModelOutput { self }
    
    var tabBarItems = CurrentValueSubject<[TabBarItems], Never>(TabBarItems.allItems)
    
    required init() {
        
    }
}
