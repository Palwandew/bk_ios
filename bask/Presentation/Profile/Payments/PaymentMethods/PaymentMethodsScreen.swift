//
//  PaymentMethodsScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 25/09/2022.
//

import SwiftUI

struct PaymentMethodsScreen: View {
    
    @ObservedObject var model: PaymentMethodsViewModel
    @State private var showDeleteDialog: Bool = false
    @State private var willPerformDeletion: Bool = false
    @State private var showWebView: Bool = false
    @State private var cardNumber: String = ""
    
    
    let methods: [Int] = [1]
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Payment methods")
                .font(.custom("Poppins-Medium", size: 26))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Spacer()
            
            switch model.state {
            case .failed:
                ErrorStateScreen()
            case .loading:
                HStack {
                    Spacer()
                    Spinner()
                    Spacer()
                }
                Spacer()
            case .success:
                if model.methods.isEmpty{
                    EmptyState(illustration: "empty_payment_method_illustration", message: "Empty_payment_method_message")
                    
                    FilledButton(label: "Add payment method", color: Color(AppColor.DARKEST_BLUE)) {
                        print("Add card")
                        model.addPaymentMethod()
                    }
                } else {
                
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack {
                            ForEach(model.methods) { item in
                                PaymentMethodItemView(card: item) {
                                    showDeleteDialog.toggle()
                                    cardNumber = item.number
                                    model.deleteCard(item)
                                }
                            }
                        }.padding(5)
                    }
                    AddPaymentButton()
                        .onTapGesture {
                            model.addPaymentMethod()
                        }
                    
                    Spacer()
                }
            case .initial:
                EmptyView()
            }
            
            
        }
        .padding([.horizontal, .bottom])
        .navigationBarTitleDisplayMode(.inline)
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
        .alertDialog(isShowing: $showDeleteDialog) {
            withAnimation {
                
                
                AlertDialog(title: "Delete card", "Do you want to delete card \(cardNumber) ?", "Cancel", "Delete"){
                    showDeleteDialog.toggle()
                } perform: {
                    showDeleteDialog.toggle()
                    model.deleteConfirmation()
                }.transition(.move(edge: .bottom))
            }
        }
        .alertDialog(isShowing: $model.willPerformDeletion, cornerRadius: 16){
            Spinner()
                .padding(-64)

        }
        .toast(isShowing: $model.toast.willShow){
            
            Toast(message: model.toast.message, style: model.toast.style)
        }
        
    }
}


struct PaymentMethodItemView: View {
    
    let card: PaymentCardViewModel
    var onDelete: (() -> Void)? = nil
    
    var body: some View {
        HStack(alignment: .center) {
            
            Image(card.type)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 18)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color.white.cornerRadius(8).shadow(radius: 4))
            
            
            
            Text(card.number)
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .padding(.leading)
            
            Spacer()
            
            if let onDelete = onDelete {
                Image(systemName: "trash.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    .onTapGesture {
                        
                            onDelete()
                        
                    }
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
            
            Text(LocalizedStringKey(title))
                .font(.custom("Poppins-Medium", size: 20))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Text(LocalizedStringKey(message))
                .font(.custom("Poppins-Medium", size: 16))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
            
            HStack{
                
                Button{
                    cancel()
                } label: {
                    Text(LocalizedStringKey(leadingItemLabel))
                        .font(.custom("Poppins-Medium", size: 16))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    
                }
                
                Spacer()
                
                Button{
                    delete()
                } label: {
                    Text(LocalizedStringKey(trailingItemLabel))
                        .font(.custom("Poppins-Medium", size: 16))
                        .foregroundColor(Color(AppColor.RED))
                    
                }
            }
            
            
        }
        
        
        .padding()
    }
}
