//
//  MyGuestListItem.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 15/09/2022.
//

import SwiftUI




struct MyGuestListItem: View {
    
    let name: String
    var body: some View {
        VStack(alignment: .leading) {
            Text("Sunny appartment with gym and swimming pool")
                .font(.custom("Poppins-Regular", size: 20))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .padding(.bottom, 4)
            
            Text("Check in: 2 PM, Check out : 3 PM")
                .font(.custom("Poppins-Regular", size: 14))
                .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                .fontWeight(.light)
                .padding(.bottom, 1)
            
            Text("\(Image(systemName: "mappin.circle.fill")) Al Khuwaildiyah, Al Qatif 32653")
                .font(.custom("Poppins-Regular", size: 12))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .fontWeight(.light)
            
            GuestInfoCard(name: name)
            
        }.padding()
    }
}

//struct MyGuestListItem_Previews: PreviewProvider {
//    static var previews: some View {
//        MyGuestListItem()//.previewLayout(.sizeThatFits)
//
////        GuestInfoCard().previewLayout(.sizeThatFits)
//    }
//}

struct GuestInfoCard: View {
    
    let name: String
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                
                Rectangle().fill(.black).frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .padding(.trailing, 8)
                
                VStack(alignment: .leading) {
                    Text("15 Jun - 16 May, 2020")
                        .font(Font.custom("Poppins-Medium", size: 12))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                        .padding(.bottom, 1)
                    
                    Text(name)
                        .font(Font.custom("Poppins-Medium", size: 16))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                }
            }
            
            Divider()
                .foregroundColor(Color.green)
                .padding(.vertical, 4)
            
            Button {
                print("message guest")
            } label: {
                HStack {
                    Spacer()
                    Text("Send Message")
                        .font(Font.custom("Poppins-Regular", size: 14))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                        .padding(8)
                    Spacer()
                        
                }.background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(AppColor.DARK_BLUE), lineWidth: 1)
                        
            )
                
            }

        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
        
        
    }
}
