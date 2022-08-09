//
//  GalleryImage.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/08/2022.
//

import SwiftUI

struct GalleryImage: View {
    
    @Binding var image: UIImage
    
    var body: some View {
        
        GeometryReader { geomerty in
            
            ZStack(alignment: .topTrailing){
                
                Image(uiImage: image)
                    .resizable()
                    .frame(width: geomerty.size.width, height: geomerty.size.height)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                
                Image(systemName: "trash")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(AppColor.DARKEST_BLUE).opacity(0.5)))
                    .padding()
                
            }
        }
    }
}

//struct GalleryImage_Previews: PreviewProvider {
//    static var previews: some View {
//        GalleryImage()
//    }
//}
