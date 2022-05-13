//
//  EmailCredentialsScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 13/05/2022.
//

import SwiftUI

struct EmailCredentialsScreen: View {
    
    //@ObservedObject var signUpViewModel: SignupViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var firstName: String = ""
    @State private var isFirstNameFocused: Bool = false
    @State private var lastName: String = ""
    @State private var isLastNameFocused: Bool = false
    @State private var city: String = ""
    @State private var isCityFocused = false
    @State private var value: Float = 0.50 // Total steps to create account -> 4 hence each step will be equal to 0.25
    @State private var rootViewDidAppear: Bool = false
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading, spacing: 32.0){
            
            Text("Create a new account")
                .fontWeight(.regular)
                .font(Font.custom("Poppins-Medium", size: 26.0))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            CustomInputField(placeHolder: "Email", text: $firstName, isFocused: $isFirstNameFocused)
                .keyboardType(.emailAddress)
            
//            PasswordInputField(placeHolder: "Password", text: $lastName)
//                .keyboardType(.default)
            
            
            Spacer()
            
            FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                
                print("tapped")
                
            }.transition(.move(edge: Edge.leading))
            
        }.padding(.horizontal, 32.0)
            .background(Color(AppColor.BACKGROUND))
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    Button(action : {
                        print("Back button tapped")
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color(AppColor.GREY))
                        
                    })
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal){
                    HStack{
                        
                        LinearProgressBar(value: $value)
                            .frame(width: UIScreen.main.bounds.width/2,height: (UIScreen.main.bounds.height * 1)/100)
                        
                    }
                }
            }
            .navigationViewStyle(.stack)
    }
}

struct EmailCredentialsScreen_Previews: PreviewProvider {
    static var previews: some View {
        EmailCredentialsScreen()
    }
}
