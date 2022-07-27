//
//  CreateAccountScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 11/05/2022.
//

import SwiftUI

struct NameCredentialsScreen: View {
    
    //@StateObject var signUpViewModel = SignupViewModel()
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var signUpViewModel: SignupViewModel
    
//    @State private var firstName: String = ""
//    @State private var isFirstNameFocused: Bool = false
//    @State private var lastName: String = ""
//    @State private var isLastNameFocused: Bool = false
//    @State private var city: String = ""
//    @State private var isCityFocused = false
//    @State private var showDetail = false
    
    private let firstNameErrorMessage: LocalizedStringKey = "valid_first_name"
    @State private var value: Float = 0.25 // Total steps to create account -> 4 hence each step will be equal to 0.25
    //@State private var rootViewDidAppear: Bool = false
    
    @State var isValid: Bool = true
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading, spacing: 32.0){
            
            Text("Create a new account")
                .fontWeight(.regular)
                .font(Font.custom("Poppins-Medium", size: 26.0))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            MaterialTextField(text: $signUpViewModel.firstName, isValid: $signUpViewModel.isValidFirstName, errorMessage: firstNameErrorMessage, placeHolder: "First name").keyboardType(.default)
            
            
            MaterialTextField(text: $signUpViewModel.lastName, isValid: $signUpViewModel.isValid, errorMessage: "", placeHolder: "Last name").keyboardType(.default)
            
            
            
            MaterialTextField(text: $signUpViewModel.city, isValid: $signUpViewModel.isValid, errorMessage: "", placeHolder: "City (Optional)").keyboardType(.default)
            
            Spacer()
            
            VStack{
                
                
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
                    
                NavigationLink(destination: EmailCredentialsScreen().environmentObject(signUpViewModel), isActive: $signUpViewModel.willShowEmailInputScreen) {
                        EmptyView()
                    }
                    
                    FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                        
                        print("tapped")
                        //showDetail.toggle()
                        //signUpViewModel.isValid.toggle()
                        signUpViewModel.validateUserFullName()
                        
                    }.transition(.move(edge: Edge.leading))
                    
                    
                
                
                
                
            }
            
            
            
        }
        .onAppear(perform: {
            print("Appearing -[---]-")
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
//                withAnimation {
//                    self.rootViewDidAppear.toggle()
//                }
//            }
            
        }).padding(.horizontal, 32.0)
            .background(Color(AppColor.BACKGROUND))
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    Button(action : {
                       // signUpViewModel.navigate.toggle()
                        
//                        withAnimation{
//                            self.rootViewDidAppear.toggle()
//                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            self.presentationMode.wrappedValue.dismiss()
                            
                        }
                        
                        
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



//struct CreateAccountScreen_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        
//        NameCredentialsScreen(signUpViewModel: SignupViewModel())
//        
//    }
//    
//}
