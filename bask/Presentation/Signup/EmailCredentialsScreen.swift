//
//  EmailCredentialsScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 13/05/2022.
//

import SwiftUI

struct EmailCredentialsScreen: View {
    
    //@ObservedObject var signUpViewModel = SignupViewModel()
    @EnvironmentObject var signUpViewModel: SignupViewModel
    @Environment(\.presentationMode) var presentationMode
//    @State private var email: String = ""
//    @State private var isFirstNameFocused: Bool = false
//    @State private var lastName: String = ""
//    @State private var isLastNameFocused: Bool = false
//    @State private var city: String = ""
//    @State private var isCityFocused = false
    @State private var value: Float = 0.50 // Total steps to create account -> 4 hence each step will be equal to 0.25
    //@State private var rootViewDidAppear: Bool = false
    
    //@State private var isValid: Bool = true
    
//    @State private var passText: String = ""
//    @State private var error: Bool? = false
//    @State private var foc: Bool = false
    @State var isEdit: Bool = false
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading, spacing: 32.0){
            
            Text("Create a new account")
                .fontWeight(.regular)
                .font(Font.custom("Poppins-Medium", size: 26.0))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            
            MaterialTextField(text: $signUpViewModel.email, isValid: $signUpViewModel.isValidEmail, errorMessage: "valid_email", placeHolder: "Email").keyboardType(.emailAddress)
            
            
            MaterialSecureField(text: $signUpViewModel.password, isEditing: $isEdit, isValid: $signUpViewModel.isValidPassword, errorMessage: "valid_password", placeHolder: "Password")
            
            
            
            Spacer()
            
            HStack{
                
                Text("Already have an account?")
                    .font(Font.custom("Poppins-Light", size: 14.0))
                    .fontWeight(.regular)
                    .foregroundColor(Color(AppColor.DARK_BLUE))
                
                Button {
                    
                    print("sign in tapped")
                    
                } label: {
                    Text("Sign in")
                        .font(Font.custom("Poppins-Light", size: 14.0))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(AppColor.DARK_BLUE))
                }
                
            }
            
            NavigationLink(destination: VerifyPhoneNumberScreen().environmentObject(signUpViewModel), isActive: $signUpViewModel.willShowVerifyPhoneScreen) {
                    EmptyView()
                }
            
            FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                
                print("tapped")
                //isValid.toggle()
                signUpViewModel.validateUserEmailAndPassword()
                
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
//            .navigationViewStyle(.stack)
    }
}

struct EmailCredentialsScreen_Previews: PreviewProvider {
    static var previews: some View {
        EmailCredentialsScreen()
    }
}
