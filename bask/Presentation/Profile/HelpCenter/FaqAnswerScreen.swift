//
//  FaqAnswerScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 25/09/2022.
//

import SwiftUI

struct FaqAnswerScreen: View {
    var body: some View {
        VStack(alignment: .leading){
            
            Text("Help Center")
                .font(.custom("Poppins-Medium", size: 26))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            ScrollView {
                Text("Most refunds arrive within 10 days, but for some payment methods and regions, it might take longer.\n\nWe send your refund on the day your reservation is cancelled. Once we send it, the refund is on its way, and your payment provider (for example, your bank or credit card issuer) will have the most up-to-date info about when funds will arrive. Here are estimates of when you can expect to see a refund—it all depends on how you paid and where you live\n\nMajor credit cards, including prepaid credit and debit cards: 5–15 business days, except in Brazil, where it can take up to 2 credit card statements")
                    .font(.custom("Poppins-Regular", size: 14))
                    .fontWeight(.thin)
                .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
            }
        
        
        }.padding(.horizontal)
        .background(Color(AppColor.BACKGROUND))
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                Button{} label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct FaqAnswerScreen_Previews: PreviewProvider {
    static var previews: some View {
        FaqAnswerScreen()
    }
}
