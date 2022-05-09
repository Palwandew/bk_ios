//
//  PostView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/05/2022.
//

import SwiftUI

struct PostView: View {
    @ObservedObject var postVM: PostViewModel
       
       public var body: some View {
           
           NavigationView {
               List {
                   
                   ForEach(postVM.posts) { post in
                       VStack{
                           Text(post.title ?? "")
                               .font(Font.custom("Poppins-Medium", size: 20))
                               .multilineTextAlignment(.leading)
                           
                           Text(post.body )
                               .font(Font.custom("Poppins-Light", size: 16))
                               .multilineTextAlignment(.leading)
                       }
                   }
               }
               .navigationBarTitle("Posts").font(Font.custom("Poppins-Medium", size: 22))
           }
               
           .onAppear {
               self.postVM.getPosts()
               self.postVM.login()
           }
       }
}

