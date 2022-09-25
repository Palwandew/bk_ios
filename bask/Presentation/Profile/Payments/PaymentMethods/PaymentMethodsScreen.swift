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
    
    let methods: [Int] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Payment methods")
                .font(.custom("Poppins-Medium", size: 26))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Spacer()
            
            
            if methods.isEmpty{
                EmptyState(illustration: "empty_payment_method_illustration", message: "You don't have any payment methods yet. You can add credit/debit card and Mada account.")
                
                FilledButton(label: "Add payment method", color: Color(AppColor.DARKEST_BLUE)) {
                    print("Add card")
                    showDeleteDialog.toggle()
                }
            } else {
            
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack {
                        PaymentMethodView(delete: $showDeleteDialog)
                        
                        PaymentMethodView(delete: $showDeleteDialog)
                    }.padding(5)
                }
                AddPaymentButton()
                    .onTapGesture {
                        showDeleteDialog.toggle()
                    }
                
                Spacer()
            }
        }
        
        .alert(isPresented: $showDeleteDialog) {
                Alert(
                    title: Text("Unable to Save Workout Data"),
                    message: Text("The connection to the server was lost."),
                    primaryButton: .default(
                        Text("Try Again"),
                        action: {
                            print("hi")
                        }
                    ),
                    secondaryButton: .destructive(
                        Text("Delete"),
                        action: {
                            print("Hi")
                        }
                    )
                )
            }
        .padding([.horizontal, .bottom])
        .navigationBarTitleDisplayMode(.inline)
//        .fullScreenCover(isPresented: $showWebView, content: {
//            NavigationView{
//                WebView(url: URL(string: "https://www.google.com")!)
//                    .navigationTitle("")
//                    .navigationBarTitleDisplayMode(.inline)
//                        .toolbar {
//                            ToolbarItem(placement: .navigationBarLeading) {
//                                Image(systemName: "chevron.backward")
//                                    .foregroundColor(.gray)
//                                    .onTapGesture {
//                                        showWebView.toggle()
//                                    }
//                            }
//                        }
//            }
//
//        })
        
//        .alertDialog(isShowing: $showDeleteDialog) {
//            withAnimation {
//                AlertDialog(title: "Delete card", "Do you want to delete card **** 4567", "Cancel", "Delete"){
//                    showDeleteDialog.toggle()
//                } perform: {
//                    print("delete card")
//                }.transition(.move(edge: .bottom))
//            }
//        }
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

struct AlertDialog: View {
    
    let title: String
    let message: String
    let leadingItemLabel: String
    let trailingItemLabel: String
    let cancel: () -> Void
    let delete: () -> Void
    
    init(title: String, _ subtitle: String, _ leadingItemLabel: String, _ trailingItemLabel: String,_ cancel: @escaping () -> Void, perform: @escaping () -> Void ){
        
        self.title = title
        self.message = subtitle
        self.leadingItemLabel = leadingItemLabel
        self.trailingItemLabel = trailingItemLabel
        self.cancel = cancel
        self.delete = perform
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            
            Text(title)
                .font(.custom("Poppins-Medium", size: 20))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Text(message)
                .font(.custom("Poppins-Medium", size: 16))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
            
            HStack{
                
                Button{
                    cancel()
                } label: {
                    Text(leadingItemLabel)
                        .font(.custom("Poppins-Medium", size: 16))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    
                }
                
                Spacer()
                
                Button{
                    delete()
                } label: {
                    Text(trailingItemLabel)
                        .font(.custom("Poppins-Medium", size: 16))
                        .foregroundColor(Color(AppColor.RED))
                    
                }
            }
            
            
        }
        
        
        .padding()
    }
}
