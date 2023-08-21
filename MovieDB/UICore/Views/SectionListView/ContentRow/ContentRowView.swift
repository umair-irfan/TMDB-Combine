//
//  ContentRowView.swift
//  TMDB-Combine
//
//  Created by umair irfan on 25/07/2023.
//

import SwiftUI

struct ContentRowView: View {
    var show: Program
    @StateObject var imageLoader = ImageLoader()
    
    var body: some View {
        ZStack {
            if !imageLoader.isLoading {
                if let image = imageLoader.image {
                    Image(uiImage: image)
                        .resizable()
                        .cornerRadius(8)
                        //.aspectRatio(contentMode: .fill)
                        .transition(.opacity)
                }
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .shimmering()
            }
        }
        .frame(width: 125, height: 170)
        .shadow(radius: 4)
        .onAppear {
            self.imageLoader.loadImage(with: self.show.posterURL)
        }
        
    }
}

