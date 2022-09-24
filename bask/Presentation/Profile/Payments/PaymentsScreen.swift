//
//  PaymentsScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 24/09/2022.
//

import SwiftUI

struct PaymentsScreen: View {
    var body: some View {
        VStack(spacing: 16) {
            NavigationLink {
                WalletScreen()
            } label: {
                PaymentsScreenListRowItem(label: "Wallet")
            }
            NavigationLink {
                Text("wall")
            } label: {
                PaymentsScreenListRowItem(label: "Payment methods")
            }
            NavigationLink {
                Text("wall")
            } label: {
                PaymentsScreenListRowItem(label: "Percentages")
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .navigationTitle("Payments")
    }
}

struct Payments_Previews: PreviewProvider {
    static var previews: some View {
        PaymentsScreen()
    }
}

struct PaymentsScreenListRowItem: View {
    
    let label: String
    
    var body: some View {
        
        
        HStack{
            Text(label)
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Spacer()
            
            Image(systemName: "chevron.forward")
                .foregroundColor(Color.gray)
        }
    }
}
