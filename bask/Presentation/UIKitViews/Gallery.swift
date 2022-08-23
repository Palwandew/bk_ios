//
//  Gallery.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/08/2022.
//

import SwiftUI
import PhotosUI
import QuickLookThumbnailing

struct Gallery: UIViewControllerRepresentable {
    @Binding var selectedImages: [UIImage]
    @Binding var isPresented: Bool
    
    
    //var newSelection = [String: PHPickerResult]()
    
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        //        config.preferredAssetRepresentationMode = .automatic
        
        config.filter = .images
        config.selectionLimit = 20
        //config.preselectedAssetIdentifiers = selectedImages.
        //config.selection = .ordered
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
            
            
            parent.selectedImages.removeAll() // remove previous pictures from the main view
            
           
            // *** Thumbnail
            
            for image in results {
                
                
                
                if image.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    
                    image.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] newImage, error in
                        if let error = error {
                            print("Can't load image \(error.localizedDescription)")
                        } else if let image = newImage as? UIImage {
                            // Add new image and pass it back to the main view
                            print("adding image")
                            
                            self?.parent.selectedImages.append(image)
                        }
                    }
                } else {
                    print("Can't load asset")
                }
                
                
                
//                let jpeg = UTType.jpeg.identifier
//                let prov = image.itemProvider
//                prov.loadFileRepresentation(forTypeIdentifier: jpeg) { [weak self] url, error in
//                    if let error = error {
//                        print("error occured \(error.localizedDescription)")
//                    }
//                    guard let url = url else {
//                        return
//                    }
//
//                    let tempDir = FileManager.default.temporaryDirectory
//                    let fileId = UUID().uuidString
//                    let localURL = tempDir.appendingPathComponent(fileId)
//                    print("local url----> \(localURL)")
//                    do {
//                        try FileManager.default.copyItem(at: url, to: localURL)
//
//                        print("************* inside do")
//
//                        print("******** after generate")
//                    } catch {
//                        print("Error writing data to file")
//                    }
//                    print("outside do ***********")
//
//                    self?.generateThumbnail(url: localURL)
//                    self?.parent.files.append(localURL)
//
//                }
            }
            
            
            
            
            
            // Thumbnail ***
            
            
            // unpack the selected items
            //              for image in results {
            //
            ////                  let identifier = image.assetIdentifier!
            ////                  newSelection[identifier] =
            //                if image.itemProvider.canLoadObject(ofClass: UIImage.self) {
            //
            //                  image.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] newImage, error in
            //                    if let error = error {
            //                      print("Can't load image \(error.localizedDescription)")
            //                    } else if let image = newImage as? UIImage {
            //                      // Add new image and pass it back to the main view
            //                        print("adding image")
            //
            //                      self?.parent.selectedImages.append(image)
            //                    }
            //                  }
            //                } else {
            //                  print("Can't load asset")
            //                }
            //              }
            
            // close the modal view
            parent.isPresented = false
        }
        
        func generateThumbnail(url: URL) {
            let size: CGSize = CGSize(width: 60, height: 90)
            let scale = UIScreen.main.scale
            
            
            // Creating request for thumbnail
            let request = QLThumbnailGenerator.Request(fileAt: url, size: size, scale: scale, representationTypes: .lowQualityThumbnail)
            
            let generator = QLThumbnailGenerator.shared
            
            generator.generateBestRepresentation(for: request) { [weak self] thumbnail, error in
                
                if let error = error {
                    
                    print("erroro occured while creating thumbnail")
                    print(error.localizedDescription)
                }
                guard let image = thumbnail else {
                    return
                }
                self?.parent.selectedImages.append(image.uiImage)
            }
        }
    }
}

//struct Gallery_Previews: PreviewProvider {
//    static var previews: some View {
//        Gallery()
//    }
//}
