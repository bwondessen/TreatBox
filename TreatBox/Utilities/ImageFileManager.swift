//
//  ImageFileManager.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/26/24.
//

import SwiftUI

class ImageFileManager {
    static let instance: ImageFileManager = ImageFileManager() // Singleton
    
    let folderName: String = "downloaded_images"
    
    private init() {
        createFolderIfNeeded()
    }
    
    // Folder for images
    private func createFolderIfNeeded() {
        // Validate folder path
        guard let url = getFolderPath() else { return }
        
        // Create folder if it doesn't exist
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                print("Created folder!")
            } catch let error {
                print("Error creating folder: \(error.localizedDescription)")
            }
        }
    }
    
    // Get path to folder
    private func getFolderPath() -> URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }
    
    // Get image path
    private func getImagePath(key: String) -> URL? {
        guard let folder = getFolderPath() else {
            return nil
        }
        
        return folder.appendingPathComponent(key + ".png")
    }
    
    // Add image to File Manager
    func add(key: String, value: UIImage) {
        // Validate image data
        guard let data = value.pngData(), let url = getImagePath(key: key) else { return }
        
        // Save image to File Manager
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving to File Manager: \(error.localizedDescription)")
        }
    }
    
    // Get image from File Manager
    func get(key: String) -> UIImage? {
        // Validate path and check if file exists
        guard let url = getImagePath(key: key), FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        
        return UIImage(contentsOfFile: url.path)
    }
}
