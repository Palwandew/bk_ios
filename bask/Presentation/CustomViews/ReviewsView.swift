//
//  ReviewsView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 07/09/2022.
//

import SwiftUI

struct ReviewsView: View {
    var body: some View {
        VStack{
            
            HStack{
                Text("Reviews")
                    .font(Font.custom("Poppins-Regular", size: 20))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                
                Spacer()
                
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text("4.3")
                    .font(Font.custom("Poppins-Medium", size: 16))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
            }
            
            CommentView()
            
            CommentView()
            
            CommentView()
        }
    }
    
    private struct CommentView: View {
        
        var body: some View {
            VStack {
                HStack {
                    
                    Rectangle().fill(.gray).frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text("Palwandew")
                            .font(Font.custom("Poppins-Medium", size: 14))
                            .foregroundColor(Color(AppColor.DARKEST_BLUE))
                        
                        Text("01 Mar 2021 - 03 Mar 2021")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    }
                    
                    Spacer()
                }
                
                HStack(alignment: .firstTextBaseline){
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("4.3")
                        .font(Font.custom("Poppins-Medium", size: 26))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    
                    Text("“Beautiful resort with beautiful garden and two inside swimming pools. Hope to visit it soon.”")
                        .font(Font.custom("Poppins-Regular", size: 14))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                }
            }
        }
    }
}

struct ReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsView()
    }
}
