//
//  AddAmountToWithdrawScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 25/09/2022.
//

import SwiftUI

struct AddAmountToWithdrawScreen: View {
    
    @ObservedObject var model: WalletViewModel
    @State private var amount: String = ""
    @State private var showKeyboard: Bool = false
    @State private var insufficentAmount: Bool = true
    @State private var status: WithdrawStatus? = nil
    var body: some View {
        ZStack {
            
            switch status {
                
            case .success:
                
                WithdrawSuccess()
                
            case .failed:
                
                WithdrawFailed()
                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
                
            case .none:
                VStack(alignment: .leading){
                    
                    Text("Enter the amount")
                        .font(.custom("Poppins-Medium", size: 26))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    
                    Text("Amount you want to withdraw from wallet to card ****4859.  You have 1200 SAR availanle and 800 SAR pending.")
                        .font(.custom("Poppins-Regular", size: 14))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    
                    Spacer()
                    
                    HStack{
                        
                        Spacer()
                        
                        if !showKeyboard{
                            Text("\(Int(amount) ?? 0) currency")
                                .font(.custom("Poppins-Medium", size: 42))
                                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                                .onTapGesture {
                                    showKeyboard.toggle()
                                }
                        } else {
                            
                            AmountInputTextField(becomeFirstResponder: $showKeyboard, text: $amount)
                                .frame(height: 200)
                        }
                        Spacer()
                        
                    }
                    
                    Spacer()
                    
                    FilledButton(label: "Withdraw", color: Color(AppColor.DARKEST_BLUE)) {
                        print("rupya joo")
                        UIApplicationHelper.dimissKeyboard()
                        showKeyboard.toggle()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            
                            withAnimation {
                                status = .failed
                            }
                        }
                    }
                }.padding(.horizontal)
                
                if !amount.isEmpty && (Int(amount) ?? 0 > 1200) {
                    
                    VStack{
                        
                        Text("Insufficent balance")
                            .font(.custom("Poppins-Regular", size: 16))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(AppColor.RED).cornerRadius(16))
                            .offset(y: -44)
                            .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .top)))
                        
                        Spacer()
                        
                    }
                }
            }
                
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

enum WithdrawStatus{
    case success
    case failed
}

struct AddAmountToWithdrawScreen_Previews: PreviewProvider {
    static var previews: some View {
        WithdrawFailed()
    }
}

struct WithdrawSuccess: View {
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            Text("Amount transferred")
                .font(.custom("Poppins-Medium", size: 26))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            EmptyState(illustration: "withdrawn_money_success_illustration", message: "Amount has been transferred to your account")
        }.padding(.horizontal)
        
    }
}

struct WithdrawFailed: View {
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            Text("Oops")
                .font(.custom("Poppins-Medium", size: 26))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            EmptyState(illustration: "withdraw_money_error_illustration", message: "Something went wrong. Please try again.")
            
            FilledButton(label: "Try again", color: Color(AppColor.DARKEST_BLUE), endIcon: "arrow.counterclockwise") {
                print("Try again ")
            }
        }.padding(.horizontal)
        
    }
}
