//
//  AppRouter.swift
//  MovieDB
//
//  Created by umair irfan on 15/08/2023.
//

import Foundation
import SwiftUI

final public class AppRouter: ObservableObject {
    
    // enum is used to specify the detail view type
    @Published var navPath = NavigationPath() // path which manages the navigations on NavigationStack
    
    // pusing the destination
    func push(to destination: any Hashable) {
        navPath.append(destination)
    }
    
    // pop pr remving the destination
    func pop() {
        navPath.removeLast()
    }
    
    // remvoing all presenters and showing root
    func popToRooot() {
        navPath.removeLast(navPath.count)
    }
}
