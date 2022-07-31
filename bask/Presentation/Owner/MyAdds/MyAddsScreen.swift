//
//  MyAddsScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 01/08/2022.
//

import SwiftUI

struct MyAddsScreen: View {
    var body: some View {
        VStack(alignment: .leading){
            
            //MARK: - Title
            
            Text("My Adds")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            
            //MARK: - New Unit
            
            RowButton(title: "Add a new unit", icon: "plus.square.fill")
                .onTapGesture {
                    print("Add new unit")
                }
            
            
            //MARK: - My Unit
            
            RowButton(title: "My Units", icon: "house.fill")
                .onTapGesture {
                    print("My Units")
                }
            
            //MARK: - Guests
            
            RowButton(title: "Guests", icon: "person.fill")
                .onTapGesture {
                    print("Guests")
                }
            
            //MARK: - Cancellation policy
            NavigationLink {
                CancellationPolicyScreen()
            } label: {
                RowButton(title: "Cancellation policy", icon: "newspaper.fill")
                    
            }


            //MARK: - My Offers
            
            RowButton(title: "My offers", icon: "flame.fill")
                .onTapGesture {
                    print("My offers")
                }
            
            //MARK: - Create Promo
            
            RowButton(title: "Create promocode", icon: "qrcode")
                .onTapGesture {
                    print("Promocode")
                }
            
            Spacer()
            
        }
        .padding()
        .background(Color.white)
        
    }
}

struct MyAddsScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        MyAddsScreen()
    }
    
    
}

struct RowButton: View {
    
    let title: String
    let icon: String
    var body: some View {
        Label {
            HStack{
                Text(title)
                    .font(Font.custom("Poppins-Light", size: 16, relativeTo: .body))
                    .fontWeight(.regular)
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
            }.padding(.leading)
                .contentShape(Rectangle())
        } icon: {
            Image(systemName: icon)
            
                .resizable()
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .frame(width: 24, height: 24)
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 8).fill(.white).shadow(radius: 2))
        }
    }
}