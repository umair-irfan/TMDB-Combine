//
//  ContentDetailView.swift
//  TMDB-Combine
//
//  Created by umair irfan on 27/07/2023.
//

import SwiftUI

struct ContentDetailView: View {
    
    @StateObject var viewModel: ContentDetailViewModel
    
    init(viewModel: ContentDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            HStack {
                Text("Content Detail")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 16)
                Spacer()
            }
        }
    }
}
