//
//  VerifyPhoneNumberScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 27/07/2022.
//

import SwiftUI

struct VerifyPhoneNumberScreen: View {
    
    @EnvironmentObject var signUpViewModel: SignupViewModel
    
    @State private var value: Float = 0.75
    @State private var text: String = ""
    @State var isValid: Bool = true
    @State var showCodesList: Bool = false
    @State var isEditing: Bool = false
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading, spacing: 32.0){
            
            Text("Verify your phone number")
                .fontWeight(.regular)
                .font(Font.custom("Poppins-Medium", size: 26.0))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            
            
            MaterialPhoneNumberField(text: $text, isValid: $isValid, errorMessage: "Enter a valid phone number", placeHolder: "123-456-789", countryCallingCode: signUpViewModel.selectedCallingCodeCountry.code) {
                print("on country code selector tapped")
                signUpViewModel.getCountriesCallingCode()
                showCodesList.toggle()
            }
            
            
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
            
            FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                
                print("tapped")
                //isValid.toggle()
                //showCodesList.toggle()
                //signUpViewModel.validateUserEmailAndPassword()
                
            }.transition(.move(edge: Edge.leading))
            
        }
        .popover(isPresented: $showCodesList, content: {
            //Text("List")
//            LazyVStack{
//            ForEach(signUpViewModel.countries, id:\.self){ country in
//                Text(country.code)
//            }
//            }
            CountriesCallingCodeScreen( onCloseTapped: {
                self.showCodesList.toggle()
            })
                .environmentObject(signUpViewModel)
        })
        .padding(.horizontal, 32.0)
        .background(Color(AppColor.BACKGROUND))
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button(action : {
                    print("Back button tapped")
                    //                        self.presentationMode.wrappedValue.dismiss()
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
    }
}

struct VerifyPhoneNumberScreen_Previews: PreviewProvider {
    static var previews: some View {
        VerifyPhoneNumberScreen()
    }
}
