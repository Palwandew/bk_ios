//
//  WalletScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 24/09/2022.
//

import SwiftUI

struct WalletScreen: View {
    
    @State var value: Float = 0.3
    
    var body: some View {

        VStack{
            
            Text("You can withdraw money 7 days after income deposited into account")
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
            
            RentCollectionIndicator(collectionStatus: $value)
            
                .frame(height: UIScreen.main.bounds.height * 0.15)
                .padding(.horizontal)
            
            WalletCard(value: $value)
            

            
        }.navigationTitle("Wallet")
    }
}

struct WalletScreen_Previews: PreviewProvider {
    static var previews: some View {
        WalletScreen()
    }
}

struct AmountIndicator: View {
    
    let label: String
    let amount: Int
    
    var body: some View {
        
        VStack(alignment: .leading) {
                Text(label)
                    .font(.custom("Poppins-Regular", size: 12))
                    .foregroundColor(.white)
                
                Text("\(amount) currency")
                    .font(.custom("Poppins-Regular", size: 20))
                    .foregroundColor(.white)
            }
       
    }
}

struct WalletCard: View {
    
    @Binding var value: Float
    var body: some View {
        VStack {
            HStack {
                AmountIndicator(label: "Available", amount: 1200)
                
                Spacer()
                
                AmountIndicator(label: "Pending", amount: 800)
            }
            
            LinearProgressBar(value: $value, background: Color(AppColor.DARK_BLUE))
                .frame(height: UIScreen.main.bounds.height * 0.015)
            
        }
        .padding()
        .background(
            ZStack {
                LinearGradient(colors: [Color(AppColor.LIGHT_VOILET), Color(AppColor.WALLET_CARD_GARD)],
                               startPoint: .top,
                               endPoint: .bottom)
                LinearGradient(colors: [Color(AppColor.DARK_BLUE), Color(AppColor.WALLET_CARD_GARD)],
                               startPoint: .bottomLeading,
                                       endPoint: .topTrailing)
            }
        )
    }
}
