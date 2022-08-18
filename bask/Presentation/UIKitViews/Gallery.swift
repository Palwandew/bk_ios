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

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
//        config.preferredAssetRepresentationMode = .automatic
        
        config.filter = .images
        
        config.selectionLimit = 20
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
              
              // unpack the selected items
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
              }
              
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
