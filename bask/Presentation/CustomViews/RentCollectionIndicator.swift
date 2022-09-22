//
//  RentCollectionIndicator.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 30/07/2022.
//

import SwiftUI

struct RentCollectionIndicator: View {
    
    @Binding var collectionStatus: Float
    let avail: String = "0";
    let pend: String = "0";
    var body: some View {
        
        GeometryReader{ geomerty in
            ZStack{
                
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color(AppColor.LIGHT_GREY))
                    .shadow(radius: 2)
                    
                
                
                VStack{
                    HStack{
                        Text("Collection of rent")
                            .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                            .font(Font.custom("Poppins-Medium", size: 12, relativeTo: .title))
                        
                        Spacer()
                        
                        Image("clock_icon")
                    }
                    
                    Spacer()
                    
                    HStack{
                        Text("Available")
                            .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                            .font(Font.custom("Poppins-Medium", size: 10, relativeTo: .title))
                        
                        Spacer()
                        
                        Text("Pending")
                            .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                            .font(Font.custom("Poppins-Medium", size: 10, relativeTo: .title))
                    }
                    
                    LinearProgressBar(value: $collectionStatus)
                        .frame(height: 9)
                    
                    HStack{
                        Text("\(avail) currency")
                            .foregroundColor(Color(AppColor.DARK_BLUE))
                            .font(Font.custom("Poppins-Medium", size: 14, relativeTo: .title))
                        
                        Spacer()
                        
                        Text("\(pend) currency")
                            .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                            .font(Font.custom("Poppins-Medium", size: 14, relativeTo: .title))
                    }
                    
                    Spacer()
                }.padding(8)
            }.frame(width: geomerty.size.width, height: geomerty.size.height)
                
        }
    }
}

//struct RentCollectionIndicator_Previews: PreviewProvider {
//    static var previews: some View {
//        RentCollectionIndicator()
//    }
//}
