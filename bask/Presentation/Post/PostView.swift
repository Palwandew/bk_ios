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
                               .font(.largeTitle)
                               .multilineTextAlignment(.leading)
                           
                           Text(post.body )
                               .font(.body)
                               .multilineTextAlignment(.leading)
                       }
                   }
               }
               .navigationBarTitle("Posts")
           }
               
           .onAppear {
               self.postVM.getPosts()
               self.postVM.login()
           }
       }
}

