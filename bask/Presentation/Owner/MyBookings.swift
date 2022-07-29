//
//  MyBookings.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 29/07/2022.
//

import SwiftUI

struct MyBookings: View {
    
    @State var value: Float = 0.50
    var body: some View {
        VStack(spacing:0){
            
            
            ZStack{
                
                Image("home_illustration")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.25)
                
                
                RentCollectionIndicator(collectionStatus: $value)
                
                    .frame(height: UIScreen.main.bounds.height * 0.15)
                    .padding(.horizontal)
            }
            


                
            
            HStack {

                Spacer()

                Text("Upcoming")
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .body))


                Spacer()

                Text("Present")
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .body))

                Spacer()

                Text("Past")
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .body))

                Spacer()
            }

            .padding(.vertical)
            .background(Rectangle().fill(Color(AppColor.BACKGROUND))
                            .shadow(color: .gray, radius: 4, x: 0, y: 3))
            
            Spacer()
//
//
//            TabView{
//                Text("Upcoming")
//
//                Text("Present")
//
//                Text("Past")
//
//            }.tabViewStyle(PageTabViewStyle())
        }
                
        
    }
}

struct MyBookings_Previews: PreviewProvider {
    static var previews: some View {
        MyBookings()
    }
}
