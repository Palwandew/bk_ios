//
//  GalleryImagesView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 25/11/2022.
//

import SwiftUI

struct GalleryImagesView: View {
    @ObservedObject var model: PhotosViewModel
    @State private var x: CGFloat = 0
    @State private var count: CGFloat = 0
    @State private var screen = UIScreen.main.bounds.width - 30
    private let size: CGSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    
    
    var body: some View {
        Text("Hi")
        //        LazyHStack(spacing: 16) {
//            ForEach(0..<images.count, id:\.self) { index in
//                 images[index]
//                    .frame(width: UIScreen.main.bounds.width - 32)
//                    .offset(x: self.x)
//                    .highPriorityGesture(DragGesture()
//                                            .onChanged({ value in
//                        print("Value ---> \(value.location.x) Translation ---> \(value.translation.width)")
//                        if value.translation.width > 0 {
//                            // Right swipe
//
//                            self.x = value.location.x
//                        } else {
//                            // Left swipe
//                            self.x = value.location.x - UIScreen.main.bounds.width
//                        }
//                    })
//                                        .onEnded({ value in
//
//                        if value.translation.width > 0 {
//                            // Right swipe
//                            if Int(count) == 0 {
//                                self.x = 0
//                            } else {
//                                print("Current count: >>>\(self.count)")
//                                self.count -= 1
//                                self.x = -(UIScreen.main.bounds.width - 16) * self.count
//                            }
//                        } else {
//                            // Left swipe
//
//                            if Int(count) == (model.images.count - 1){
//                                self.x = -(UIScreen.main.bounds.width - 16) * self.count// this will go to first
//                            }
//
//                            if Int(count) < (model.images.count - 1) {
//                                self.count += 1
//                                self.x = -(UIScreen.main.bounds.width - 16) * self.count
//                            }
//                        }
//                    })
//                ).animation(.spring(), value: self.x)
//            }
//        }.frame(maxWidth: UIScreen.main.bounds.width - 32, alignment: .leading)
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

//struct GalleryImagesView_Previews: PreviewProvider {
//    static var previews: some View {
//        GalleryImagesView()
//    }
//}
