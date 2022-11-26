//
//  ImageView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 12/09/2022.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject private var imageLoader: ImageLoader
    
    init(withURL url: String, size: CGSize) {
        imageLoader = ImageLoader(urlString:url, size: size, imageSource: .remote)
        print("IV remote")
    }
    
    init(withLocalURL url: String, size: CGSize){
        imageLoader = ImageLoader(urlString: url, size: size, imageSource: .local)
        print("IV local")
    }
    
    var body: some View {
        
        imageLoader.image
            .resizable()
            .aspectRatio(contentMode: .fit)
            
    }
    
    
}

