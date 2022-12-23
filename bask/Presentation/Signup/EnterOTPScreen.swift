//
//  EnterOTPScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 27/07/2022.
//

import SwiftUI

struct EnterOTPScreen: View {
    
    @EnvironmentObject var signUpViewModel: SignupViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var value: Float = 0.95
    @State var text: String = ""
    @State var responder: Bool = true
    @State var firstDigit: String = "a"
    @State var secondInput: Bool = false
    @State var secondDigit: String = ""
    @State var fieldFocus = [false, false]
    @State var first: String = ""
    @State var second: String = ""
    @State var third: String = ""
    @State var fourth: String = ""
    @State var fifth: String = ""
    @State var sixth: String = ""
    var body: some View {
        
        
        VStack(alignment: HorizontalAlignment.leading, spacing: 4){
            
            Text("Enter OTP")
                .fontWeight(.regular)
                .font(Font.custom("Poppins-Medium", size: 26.0))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
//            Text("We have sent you OTP on \(signUpViewModel.selectedCallingCodeCountry.code)\(signUpViewModel.phoneNumber)")
//                .font(Font.custom("Poppins-Light", size: 16, relativeTo: .body))
//                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
            
            Spacer()
            
            
            HStack {
                Spacer()
                
                OTPInput(firstDigit: $first, secondDigit: $second, thirdDigit: $third, fourthDigit: $fourth, fifthDigit: $fifth, sixthDigit: $sixth)
                    .frame(width: 30, height: 30)
                
                
                
                
                
                
                
                
                Spacer()
            }
            
            HStack{
                Spacer()
                Text("Didn't receive the code?")
                    .font(Font.custom("Poppins-Light", size: 14, relativeTo: .callout))
                    .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                
                
                Spacer()
            }.padding(.top)
            
            
            Spacer()
            
            
            
            HStack {
               
                
                Spacer()
                FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                    
                    print("tapped")
                
                    //isValid.toggle()
                    //showCodesList.toggle()
                    //signUpViewModel.validateUserEmailAndPassword()
                    
                }.transition(.move(edge: Edge.leading))
                
                
            }
            
        }
        .padding(.horizontal, 32.0)
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
    }
    
    
}

struct EnterOTPScreen_Previews: PreviewProvider {
    static var previews: some View {
        EnterOTPScreen()
    }
}
