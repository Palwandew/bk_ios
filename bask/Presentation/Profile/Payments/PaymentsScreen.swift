//
//  PaymentsScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 24/09/2022.
//

import SwiftUI

struct PaymentsScreen: View {
    @StateObject var model: PaymentMethodsViewModel  = PaymentMethodsViewModel(PaymentMethodUsecase(repo: PaymentMethodsProtocolImpl()))
    
    var body: some View {
        VStack(spacing: 16) {
            NavigationLink {
                WalletScreen(paymentMethodsVM: model)
            } label: {
                PaymentsScreenListRowItem(label: "Wallet")
            }
            NavigationLink {
                PaymentMethodsScreen(model: model)
            } label: {
                PaymentsScreenListRowItem(label: "Payment methods")
            }
            NavigationLink {
                FacilityPercentageScreen()
            } label: {
                PaymentsScreenListRowItem(label: "Percentages")
                    
            }.isDetailLink(false)
            
            Spacer()
        }
        .padding([.horizontal, .top])
        .navigationTitle("Payments")
        .fullScreenCover(isPresented: $model.showWebView, onDismiss: {
            model.updatePaymentMethodsList()
        }, content: {
            NavigationView{
                WebView(url: model.addPaymentMethodURL ?? URL(string: "https://site.paytabs.com/en/payment-methods/")!)
                    .navigationTitle("")
                    .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Image(systemName: "chevron.backward")
                                    .foregroundColor(.gray)
                                    .onTapGesture {
                                        model.showWebView.toggle()
                                    }
                            }
                        }
            }

        })
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
            Text(LocalizedStringKey(label))
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Spacer()
            
            Image(systemName: "chevron.forward")
                .foregroundColor(Color.gray)
        }
    }
}
