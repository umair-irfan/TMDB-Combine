//
//  ImageLoader.swift
//  TMDB-Combine
//
//  Created by umair irfan on 07/08/2023.
//

import SwiftUI

class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    @Published var isLoading = false
    
    private let imageCache = NSCache<NSString, UIImage>()
    private var currentURL: URL?
    
    func loadImage(with url: URL) {
        currentURL = url
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            image = cachedImage
            return
        }
        
        isLoading = true
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, let image = UIImage(data: data), self.currentURL == url else {
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
                return
            }
            
            self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
            
            DispatchQueue.main.async {
                self.isLoading = false
                self.image = image
            }
        }
        
        task.resume()
    }
    
}
