//
//  View+Extention.swift
//  MovieDB
//
//  Created by umair irfan on 08/08/2023.
//

import SwiftUI

extension View {
    func shimmering() -> some View {
        self.modifier(Shimmering())
    }
}

