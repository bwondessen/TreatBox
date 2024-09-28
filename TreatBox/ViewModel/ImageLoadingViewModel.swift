//
//  ImageLoadingViewModel.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/26/24.
//

import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    let manager: ImageCacheManager = ImageCacheManager.instance
    
    let urlString: String
    let imageKey: String
    
    init(url : String, key: String) {
        urlString = url
        imageKey = key
        getImage()
    }
    
    // Try to get image from cache, if it fails, then download
    func getImage() {
        if let savedImage = manager.get(key: imageKey) {
            image = savedImage
        } else {
            downloadImage()
        }
    }
    
    // Download Image
    func downloadImage() {
        isLoading = true
        
        // Validate URL
        guard let url = URL(string: urlString ) else {
            isLoading = false
            return
        }
        
        // Download and validate image
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] image in
                // Validate reference to self and image
                guard let self = self, let image = image else { return }
                
                self.image = image
                self.manager.add(key: self.imageKey, value: image) // Save image to cache
            }
            .store(in: &cancellables)
    }
}
