//
//  PhotosViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 23/08/2022.
//

import SwiftUI
import ImageIO

class PhotosViewModel: ObservableObject {
    
    private let uploadPhotoUsecase: PhotosUsecase
    var facilityID: String? = nil
    
    @Published var progress: Double = 0.0
    @Published var showProgress: Bool = false 
    @Published var isUploading: Bool = false
    @Published var uploadingCompleted: Bool = false 
    @Published var urls: [URL] = []
    @Published var images: [Image] = []
    @Published var showPublishAdScreen: Bool = false
    
    init(useCase: PhotosUsecase){
        print("PhotoViewModel ---> init()")
        uploadPhotoUsecase = useCase
        //manager = uploader
    }
    
    
    func onCreateTapped(facilityID: String?){

        self.facilityID = facilityID

        if photosAvailableToUpload() {
            uploadPhotos()
        } else {
            showPublishAdScreen.toggle()
        }
        
    }
    
    private func photosAvailableToUpload() -> Bool {
        return !images.isEmpty
    }
    
    private func uploadPhotos(){
        
        guard let facilityID = self.facilityID else {
            return
        }

        
        self.showProgress = true
        var image = 1
        var imagesToUpload = urls
    

        for photoURL in imagesToUpload {
                
                self.uploadPhotoUsecase.uploadPhoto(of: facilityID, from: photoURL) { progress in
                    
                    
                    let progressToShow = Float(progress) * 1 / Float(self.images.count) * Float(image)
                    //let test = Double(image) * progress / Double(self.images.count)
                    print("Progress to show ---> \(progressToShow)")
                    print("Progress ---> \(self.progress)")
                    DispatchQueue.main.async {
                        self.progress = Double(progressToShow) * Double(image)
                        
                    }
                } completion: { result in
                    switch result{
                    case .failure(let error):
                        print("Error uploading picture \(error.localizedDescription)")
                    case .success(let message):
                        print("Uploaded at: \(message)")
                        print("url that upload \(photoURL)")
                        imagesToUpload.removeAll(where: {$0 == photoURL})
                        image += 1
                        if imagesToUpload.isEmpty{
                            DispatchQueue.main.async {
                                self.uploadPhotoUsecase.finishURLSession()
                                self.showPublishAdScreen = true
                            }
                        }
                    }
                }
        }
        print("Outside for loop")
        if imagesToUpload.isEmpty{
            showPublishAdScreen = true
        }
    }
//
        //showProgress.toggle()
    
    
    //    func uploadPhotos(
    //        body: Data
    //    ) {
    //
    //        guard let uploadUrl = URL(string: "https://bask-static.s3.ap-south-1.amazonaws.com/0b69ddee-b105-4339-8911-b39f72a5a51a.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAV6EXK5DMDYAFPP45%2F20220822%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20220822T212542Z&X-Amz-Expires=36400&X-Amz-Signature=dcb8d64ae7064ad2a45844e3a83b57732e3039f34cd0ccafcbd3a1a527d60ad9&X-Amz-SignedHeaders=host") else {
    //            print("error creating upload-url")
    //            return
    //        }
    //        isUploading.toggle()
    //
    //
    //
    //
    //    }
    
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
