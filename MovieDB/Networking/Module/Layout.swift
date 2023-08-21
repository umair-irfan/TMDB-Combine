//
//  Layout.swift
//  MovieDB
//
//  Created by umair irfan on 08/08/2023.
//

import Foundation

public struct Layout: Identifiable {
    public let id = UUID()
    public let module: Module
    public let title: String
    public var type: ModuleType
    
    public init(module: Module, title: String, type: ModuleType) {
        self.module = module
        self.title = title
        self.type = type
    }
}

//MARK: - MOCK Layout
extension Layout {
    public static var mockData = [Layout(module: Module.mockedData, title: "Section:1", type: .PlayingNow),
                                  Layout(module: Module.mockedData, title: "Section:2", type: .Upcoming(.movies))]
}
