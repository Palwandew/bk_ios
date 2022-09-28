//
//  HelpCenterScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 25/09/2022.
//

import SwiftUI

struct HelpCenterScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading){
            
            Text("Help Center")
                .font(.custom("Poppins-Medium", size: 26))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Text("Read FAQ to find answer on a question. If you didn`t find - write us to bask@gmail.com")
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                
            
            LazyVStack(spacing: 32) {
                FAQ(question: "What is the cancellation policy for my stay?")
                
                FAQ(question: "Can I pay with any currency?")
                
                FAQ(question: "When am I charged for a reservation?")
                
                FAQ(question: "When will I get my refund?")
            }
            
            Spacer()
            
        }
        .padding(.horizontal)
        .background(Color(AppColor.BACKGROUND))
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                Button{} label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.gray)
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
            }
        }
    }
}

struct HelpCenterScreen_Previews: PreviewProvider {
    static var previews: some View {
        HelpCenterScreen()
    }
}

struct FAQ: View {
    
    let question: String
    
    
    var body: some View {
        HStack{
            Text(LocalizedStringKey(question))
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Spacer()
            
            Image(systemName: "chevron.forward")
                .foregroundColor(.gray)
        }
    }
}
