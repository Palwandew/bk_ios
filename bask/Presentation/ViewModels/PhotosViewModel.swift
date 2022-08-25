//
//  PhotosViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 23/08/2022.
//

import Foundation
import UserNotifications
import ImageIO

class PhotosViewModel: ObservableObject {
    
    private let useCase: PhotosUsecase
    let facilityID = "879605bb-766e-43bf-9e08-04900a7734eb"
    
    @Published var progress: Double = 0.0
    @Published var isUploading: Bool = false
    @Published var images: [URL] = []
    @Published var showPublishAdScreen: Bool = false

    
    init(useCase: PhotosUsecase){
        self.useCase = useCase
        //manager = uploader
    }
    
    
    func onCreateTapped(){
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
        for photoPathURL in images {
            useCase.uploadPhoto(of: facilityID, from: photoPathURL) { progress in
                print("Progress \(progress)")
            } completion: { result in
                switch result{
                case .failure(let error):
                    print("Error uploading picture \(error.localizedDescription)")
                case .success(let message):
                    print("Uploaded at: \(message)")
                
                }
            }
        }
    }
    
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
    
    func imageIo(url: URL) -> CGImage? {
        let url = url as CFURL
        var thumbNail: CGImage? = nil
        if let imageSource = CGImageSourceCreateWithURL(url, nil) {
            //let maxPixel: CFNumber = 200 as CFNumber
            let createThumbnail: CFBoolean = kCFBooleanTrue
            let options = [kCGImageSourceCreateThumbnailFromImageIfAbsent: createThumbnail] as CFDictionary
            
            thumbNail = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options)
        }
        return thumbNail
    }
    
    func addURL(_ url: URL) {
        
        images.append(url)
        
    }
}
