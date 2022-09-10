//
//  Gallery.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/08/2022.
//

import SwiftUI
import PhotosUI

struct Gallery: UIViewControllerRepresentable {
    
    @EnvironmentObject var viewModel: PhotosViewModel
    @Binding var selectedImagesThumbnails: [Image]
    @Binding var isPresented: Bool
    
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        
        config.filter = .images
        config.selectionLimit = 20
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: Gallery
        
        init(_ parent: Gallery) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            
            parent.selectedImagesThumbnails.removeAll() // remove previous pictures from the main view
            parent.viewModel.images.removeAll()
            
            for image in results {
                let jpeg = UTType.jpeg.identifier
                let prov = image.itemProvider
                prov.loadFileRepresentation(forTypeIdentifier: jpeg) { url, error in
                    
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                    }
                    guard let url = url else { return }
                    
                    let tempDir = FileManager.default.temporaryDirectory
                    let imageId = UUID()
                    let localURL = tempDir.appendingPathComponent(imageId.uuidString)
                    
                    do {
                        try FileManager.default.copyItem(at: url, to: localURL)
                    } catch {
                        print("Error writing data to file")
                    }
                    
                    DispatchQueue.main.async {
                        self.parent.viewModel.addURL(localURL)
                        let imageThumbnail = self.generateThumbnail(of: localURL)/// move it to bg thread
                        self.parent.selectedImagesThumbnails.append(imageThumbnail)
                        
                    }
                    
                    
                }
            }
            parent.isPresented = false
        }
        
        func generateThumbnail(of url: URL) -> Image {
            let url = url as CFURL
            var thumbNail: Image? = nil
            let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
            if let imageSource = CGImageSourceCreateWithURL(url, imageSourceOptions) {
                let maxPixel: CFNumber = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 0.8 as CFNumber
                //let createThumbnail: CFBoolean = kCFBooleanTrue
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
}






//if image.itemProvider.canLoadObject(ofClass: UIImage.self) {
//
//    image.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] newImage, error in
//        if let error = error {
//            print("Can't load image \(error.localizedDescription)")
//        } else if let image = newImage as? UIImage {
//            // Add new image and pass it back to the main view
//            print("adding image")
//
//            self?.parent.selectedImages.append(image)
//        }
//    }
//} else {
//    print("Can't load asset")
//}
