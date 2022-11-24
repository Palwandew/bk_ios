//
//  GalleryImage.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/08/2022.
//

import SwiftUI

struct GalleryImage: View {
    
    let image: Image
    let onDelete: () -> Void
    var body: some View {
        
        GeometryReader { geomerty in
            
            ZStack(alignment: .topTrailing){
                
                
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geomerty.size.width, height: geomerty.size.height)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
//                RoundedRectangle(cornerRadius: 10)
//                    .fill(.gray)
//                    .frame(width: geomerty.size.width, height: geomerty.size.height)
                
                    
                Image(systemName: "trash")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(AppColor.DARKEST_BLUE).opacity(0.5)))
                    .padding()
                    .onTapGesture {
                        onDelete()
                    }
                
            }
        }
    }
}

//struct GalleryImage_Previews: PreviewProvider {
//    static var previews: some View {
//        GalleryImage()
//    }
//}
