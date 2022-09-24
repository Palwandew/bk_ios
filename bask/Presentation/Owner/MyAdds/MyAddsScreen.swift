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
            
            Text("My Ads")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            
            //MARK: - New Unit
            NavigationLink{
                FacilityNameScreen()
            } label: {
                RowButton(title: "Add a new unit", icon: "plus.square.fill")
            }
            
            
            //MARK: - My Units
            NavigationLink{
                MyUnitsScreen()
            } label: {
                RowButton(title: "My Units", icon: "house.fill")

            }
            
            //MARK: - Guests
            
            NavigationLink{
                MyGuestsScreen()
            } label: {
                RowButton(title: "Guests", icon: "person.fill")

            }
            
            //MARK: - Cancellation policy
            NavigationLink {
                CancellationPolicyScreen()
            } label: {
                RowButton(title: "Cancellation policy", icon: "newspaper.fill")
                    
            }


            //MARK: - My Offers
            NavigationLink {
                MyOffersScreen()
            } label: {
                RowButton(title: "My offers", icon: "flame.fill")
            }
            
            //MARK: - Create Promo
            
            NavigationLink {
                CreatePromoCodesScreen()
            } label: {
                RowButton(title: "Create promocode", icon: "qrcode")
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
                Text(LocalizedStringKey(title))
                    .font(Font.custom("Poppins-Light", size: 16, relativeTo: .body))
                    .fontWeight(.regular)
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                Spacer()
                Image(systemName: "chevron.forward")
                    .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
            }.padding(.leading)
                .contentShape(Rectangle())
        } icon: {
            Image(systemName: icon)
            
                .resizable()
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 8).fill(.white).shadow(radius: 2))
        }
    }
}
