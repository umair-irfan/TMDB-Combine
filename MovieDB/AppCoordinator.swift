//
//  AppCoordinator.swift
//  MovieDB
//
//  Created by umair irfan on 15/08/2023.
//

import Foundation
import SwiftUI
import Combine


public protocol AppCoordinator {
    var appRouter: AppRouter { get }
    // pusing the destination
    func push(to destination: any Hashable)
    // pop pr remving the destination
    func pop()
    // remvoing all presenters and showing root
    func popToRooot()
}

// AppCoordinator default implementations
public extension AppCoordinator {
    // pusing the destination
    func push(to destination: any Hashable) {
        appRouter.push(to: destination)
    }
    // pop pr remving the destination
    func pop() {
        appRouter.pop()
    }
    // remvoing all presenters and showing root
    func popToRooot() {
        appRouter.popToRooot()
    }
}
