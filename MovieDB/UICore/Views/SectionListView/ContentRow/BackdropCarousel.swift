//
//  BackdropCarousel.swift
//  MovieDB
//
//  Created by umair irfan on 08/08/2023.
//

import SwiftUI

struct BackdropCarousel: View {
    
    let show: Program
    @StateObject var imageLoader = ImageLoader()
    
    var body: some View {
        ZStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                .resizable()
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .shimmering()
            }
           
        }
        .frame(width: UIScreen.main.bounds.width / 1.20 , height: 170)
        .cornerRadius(8)
        .shadow(radius: 4)
        .onAppear {
            self.imageLoader.loadImage(with: self.show.backdropURL)
        }
    }
}
