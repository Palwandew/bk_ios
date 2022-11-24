//
//  ImageLoader.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 12/09/2022.
//

import SwiftUI

class ImageLoader: ObservableObject {
    
    @Published var image = Image("icon_image_place_holder")
    
    init(urlString:String, size: CGSize) {
        print("Init --> ImageLodeer")
        
        if !urlString.isEmpty {
            loadImage(urlString: urlString, size: size)
        }
    }
    
    
    
   
    
    /// Loads an image from cache if available with the provided url as a key. Otherwise, will
    /// perform a network call.
    /// - Parameters:
    ///   - urlString: URL of the image on Network.
    ///   - size: Size of the view that will render the Image.
    private func loadImage(urlString: String, size: CGSize){
        
        if didLoadImageFromCache(forKey: urlString) {
            print("Cache Hit")
            return
        } else {
            print("Cache Miss")
            loadImageFromNetwork(urlString: urlString, size: size)
        }
        
    }
    
    /// Downloads an image file from network directed by the urlString and
    /// creates a thumbnail for the given size and caches it.
    /// - Parameters:
    ///   - urlString: A string indicating the path of image file on a network.
    ///   - size: Size of the View that will render the thumbnail.
    private func loadImageFromNetwork(urlString: String, size: CGSize) {
        
        let url = URL(string: urlString)
        
        PhotosDownloadManager.shared.downloadImage(at: url) { [weak self] result in
            switch result {
                
            case .failure(let error):
                print("error occured: \(error.localizedDescription)")
                
            case .success(let fileURL):
                print(" File is located at \(fileURL.absoluteString)")
                
                let thumbnail = self?.generateThumbnail(path: fileURL, size: size)
                
                guard let downsampledImage = thumbnail else {
                    return
                }
                
                ImageCacheHelper.shared.set(forKey: urlString, image: downsampledImage)
                
                DispatchQueue.main.async {
                    self?.image = Image(decorative: downsampledImage, scale: 1)
                }
            }
        }
    }
    
    /// Checks if the image is loaded from Cache.
    /// - Parameter forKey: key for the file in the cache.
    /// - Returns: True if the file is loaded from Cache. False otherwise.
    private func didLoadImageFromCache(forKey: String) -> Bool {
        guard let cacheImage = ImageCacheHelper.shared.get(forKey: forKey) else {
            return false
        }
        DispatchQueue.main.async {
            self.image = Image(decorative: cacheImage, scale: 1)
        }
        
        return true
    }
    
    /// Creates a thumbnail of the file indicated by path url.
    /// - Parameters:
    ///   - url: URL of the file.
    ///   - size: size of the View that will contain this thumbnail.
    /// - Returns: A CGImage if downsampling is successfull. Nil otherwise.
    private func generateThumbnail(path url: URL, size: CGSize) -> CGImage? {
        
        let url = url as CFURL
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithURL(url, imageSourceOptions) else  {
            return nil
        }
        
        let maxPixel: CFNumber = max(size.width, size.height) * 1 as CFNumber
        
        let options =
        [kCGImageSourceCreateThumbnailFromImageAlways: true,
                 kCGImageSourceShouldCacheImmediately: true,
           kCGImageSourceCreateThumbnailWithTransform: true,
                  kCGImageSourceThumbnailMaxPixelSize: maxPixel] as CFDictionary
        print("cgImage created")
        return CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options)
    }
    
    deinit{
        print("Deinit ----> ImageLoader")
    }
}
