//
//  Gallery.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/08/2022.
//

import SwiftUI
import PhotosUI

struct Gallery: UIViewControllerRepresentable {
    @Binding var selectedImages: [UIImage]
    @Binding var isPresented: Bool
    @Binding var files: [URL]

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
              
            parent.files.removeAll()
            // *** Thumbnail
            
            for image in results {
                let jpeg = UTType.jpeg.identifier
                let prov = image.itemProvider
                prov.loadFileRepresentation(forTypeIdentifier: jpeg) { url, error in
                    if let error = error {
                        print("error occured \(error.localizedDescription)")
                    }
                    guard let url = url else {
                        return
                    }
                    print("URL: \(url)")
                    
                    self.parent.files.append(url)
                }
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
    }
}

//struct Gallery_Previews: PreviewProvider {
//    static var previews: some View {
//        Gallery()
//    }
//}
