//
//  PictureSliderView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/08/2022.
//

import SwiftUI

struct PictureSliderView: View {
    
    @Binding var images: [UIImage]
    
    var body: some View {
        TabView{
            ForEach(images, id: \.self) { item in
                Image(uiImage: item)
                    .resizable()
                    .scaledToFill()
            }
        }.tabViewStyle(PageTabViewStyle())
    }
}

//struct PictureSliderView_Previews: PreviewProvider {
//    static var previews: some View {
//        PictureSliderView()
//    }
//}
