//
//  PhotosViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 23/08/2022.
//

import SwiftUI
import ImageIO

class PhotosViewModel: ObservableObject {
    
    @Published var urls: [URL] = []
    @Published var images: [Image] = []
    
    private var photosAvailableToUpload: Bool {
        return !images.isEmpty
    }
    
    
    func askPermissionForNotification(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .sound]) { success, error in
            if let error = error {
                print("error occured \(error.localizedDescription)")
            }
            
            if success {
                print("Clear to go....")
            } else {
                print("Oops! Not authorized...")
            }
        }
    }
    
    private func createNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Picture Uploaded"
        content.subtitle = "Heehaa"
        content.sound = UNNotificationSound.default
        
        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
    
    func handlieURL(_ url: URL) {
        
        urls.append(url)
        
        images.append(generateThumbnail(of: url))
        
        self.objectWillChange.send()
    }
    
    func removePhoto(at index: Int){
        images.remove(at: index)
        urls.remove(at: index)
        self.objectWillChange.send()
    }
    
    private func generateThumbnail(of url: URL) -> Image {
        let url = url as CFURL
        var thumbNail: Image? = nil
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        if let imageSource = CGImageSourceCreateWithURL(url, imageSourceOptions) {
            let maxPixel: CFNumber = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 0.8 as CFNumber
            let options =
            [kCGImageSourceCreateThumbnailFromImageAlways: true,
             kCGImageSourceShouldCacheImmediately: true,
             kCGImageSourceCreateThumbnailWithTransform: true,
             kCGImageSourceThumbnailMaxPixelSize: maxPixel] as CFDictionary
            
            guard let cgImg = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options) else {
                return Image(systemName: "photo.fill")
            }
            
            print("cgImage created")
            
            thumbNail = Image(decorative: cgImg, scale: 3.0)
        }
        return thumbNail ?? Image(systemName: "photo.fill")
    }
}
