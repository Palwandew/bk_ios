//
//  WalletScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 24/09/2022.
//

import SwiftUI

struct WalletScreen: View {
    
    @ObservedObject var paymentMethodsVM: PaymentMethodsViewModel
    @StateObject private var model: WalletViewModel = WalletViewModel(GetWalletStatusUsecase(WalletProtocolImpl()))
    @State private var value: Float = 0.60
    @State private var showHalfModal: Bool = false
    var body: some View {
        
        ZStack {
            VStack(alignment: .leading){
                
                Text("Wallet_subtitle")
                    .font(.custom("Poppins-Regular", size: 16))
                    .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                
                WalletCard(model: model)
                
                Spacer()
                
                if !showHalfModal{
                    FilledButton(label: "Withdraw money", color: Color(AppColor.DARKEST_BLUE)) {
                        print("money")
                        withAnimation {
                            showHalfModal.toggle()
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            if showHalfModal {
                VStack {
                    Spacer()
                    VStack(alignment: .leading){
                        
                        Spacer()
                        
                        HStack{
                            
                            Spacer()
                            
                            RoundedRectangle(cornerRadius: 8).fill(.gray.opacity(0.5)).frame(width: 50, height: 5)
                            
                            Spacer()
                            
                        }.padding(.top)
                        
                        Text("Choose a payment method")
                            .font(.custom("Poppins-Regular", size: 20))
                            .foregroundColor(Color(AppColor.DARK_BLUE))
                        
                            .onTapGesture {
                                withAnimation {
                                    showHalfModal.toggle()
                                }
                            }
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVStack {
                                ForEach(paymentMethodsVM.methods) { item in
                                    
                                    NavigationLink{
                                        AddAmountToWithdrawScreen(model: model)
                                    } label: {
                                        PaymentMethodItemView(card: item)
                                    }
                                    
                                    
                                }
                            }.padding(5)
                        }
                        
                        AddPaymentButton()
                            .onTapGesture {
                                paymentMethodsVM.addPaymentMethod()
                            }
                        
                    }.padding(.horizontal)
                        .padding(.bottom, 32)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.532)
                        .background(Color.white)
                        .roundCorners(radius: 20, [.topLeft, .topRight])
                    
                }.background(Color.black.opacity(0.5))
                    .ignoresSafeArea(.all, edges: .all)
                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
                
                
            }
        }
        .navigationTitle("Wallet")
        .navigationBarBackButtonHidden(showHalfModal)
    }
}

//struct Wallet_Previews: PreviewProvider {
//    static var previews: some View {
//        WalletScreen()
//    }
//}



struct AmountIndicator: View {
    
    let label: String
    let amount: Int
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(label)
                .font(.custom("Poppins-Regular", size: 12))
                .foregroundColor(.white)
                .unredacted()
            
            Text("\(amount) currency")
                .font(.custom("Poppins-Regular", size: 20))
                .foregroundColor(.white)
        }
        
    }
}

struct WalletCard: View {
    
    @ObservedObject var model: WalletViewModel
    @State var value: Float = 0.1
    var body: some View {
        VStack {
            HStack {
                AmountIndicator(label: "Available", amount: model.wallet.availableAmount)
                    .redacted(reason: model.state != .success ? .placeholder : [])
                
                Spacer()
                
                AmountIndicator(label: "Pending", amount: model.wallet.pendingAmount)
                    .redacted(reason: model.state != .success ? .placeholder : [])
            }
            
            LinearProgressBar(value: $value, background: Color(AppColor.DARKEST_BLUE))
                .frame(height: UIScreen.main.bounds.height * 0.015)
            
        }
        .padding()
        .padding(.vertical)
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
        .cornerRadius(8)
    }
}

struct PaymentHistoryView: View {
    var body: some View {
        HStack {
            Circle()
                .fill(Color(0xffEB001B))
                .overlay(
                    Circle()
                        .fill(Color(0xffF79E1B))
                        .offset(x:15)
                )
                .frame(width: 20, height: 20)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(RoundedRectangle(cornerRadius: 8).fill(.white).shadow(radius: 4).offset(x:8))
            
            Spacer()
            
            Text("**** **** **** 1234")
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Spacer()
            
            Text("\(-200) currency")
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
        }
    }
}


