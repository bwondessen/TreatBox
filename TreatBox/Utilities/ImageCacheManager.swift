//
//  ImageCacheManager.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/26/24.
//

import SwiftUI

class ImageCacheManager {
    static let instance: ImageCacheManager = ImageCacheManager() // Singleton
    
    private init() { }
    
    // Create cache for images
    var imageCache: NSCache<NSString, UIImage> = {
        var cache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
        cache.countLimit = 100 // Tell cache to hold the 100 most recent images
        cache.totalCostLimit = 1024 * 1024 * 200 // Total amount of data that cache can hold
        
        return cache
    }()
    
    // Add image to cache
    func add(key: String, value: UIImage) {
        imageCache.setObject(value, forKey: key as NSString)
    }
    
    // Get image from cache
    func get(key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
}
