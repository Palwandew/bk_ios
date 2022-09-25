//
//  PaymentMethodsScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 25/09/2022.
//

import SwiftUI

struct PaymentMethodsScreen: View {
    
    @State var showDeleteDialog: Bool = false
    @State var showWebView: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Payment methods")
                .font(.custom("Poppins-Medium", size: 26))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Spacer()
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    PaymentMethodView(delete: $showDeleteDialog)
                    
                    PaymentMethodView(delete: $showDeleteDialog)
                }.padding(5)
            }
            AddPaymentButton()
                .onTapGesture {
                    showWebView.toggle()
                }
            
            Spacer()
        }
        .padding([.horizontal, .bottom])
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $showWebView, content: {
            NavigationView{
                WebView(url: URL(string: "https://www.google.com")!)
                    .navigationTitle("")
                    .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Image(systemName: "chevron.backward")
                                    .foregroundColor(.gray)
                            }
                        }
            }
            
        })
        
        .alertDialog(isShowing: $showDeleteDialog) {
            withAnimation {
                DeleteCardDialog {
                    showDeleteDialog.toggle()
                } delete: {
                    print("delete card")
                }.transition(.move(edge: .bottom))
            }
        }
    }
}

struct PaymentMethodsScreen_Previews: PreviewProvider {
    static var previews: some View {
        PaymentMethodsScreen()
    }
}


struct PaymentMethodView: View {
    
    @Binding var delete: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            
            Image("logo_mastercard")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 18)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color.white.cornerRadius(8).shadow(radius: 4))
            
            
            
            Text("**** **** **** 1234")
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .padding(.leading)
            
            Spacer()
            
            Image(systemName: "trash.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .onTapGesture {
                    delete.toggle()
                }
                
            
        }
    }
}


struct AddPaymentButton: View {
    var body: some View {
        HStack{
            
            Image(systemName: "plus.rectangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 18)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(RoundedRectangle(cornerRadius: 8).fill(.white).shadow(radius: 4))
            
            Text("Add payment method")
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.DARK_BLUE))
                .padding(.leading)
        }
    }
}

struct DeleteCardDialog: View {
    
    let cancel: () -> Void
    let delete: () -> Void
    
    init(_ cancel: @escaping () -> Void, delete: @escaping () -> Void ){
        self.cancel = cancel
        self.delete = delete
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            
            Text("Delete card")
                .font(.custom("Poppins-Medium", size: 20))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Text("Do you want to delete card **** 4567?")
                .font(.custom("Poppins-Medium", size: 16))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
            
            HStack{
                
                Button{
                    cancel()
                } label: {
                    Text("Cancel")
                        .font(.custom("Poppins-Medium", size: 16))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    
                }
                
                Spacer()
                
                Button{
                    delete()
                } label: {
                    Text("Delete")
                        .font(.custom("Poppins-Medium", size: 16))
                        .foregroundColor(Color(AppColor.RED))
                    
                }
            }
            
            
        }.padding()
    }
}
