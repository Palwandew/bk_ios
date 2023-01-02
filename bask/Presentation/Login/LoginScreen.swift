//
//  LoginScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/05/2022.
//

import SwiftUI

struct LoginScreen: View {
    
    @ObservedObject var vm: SignInSignUpSelectionViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    
    enum Field: Hashable {
            case email
            case password
        }

   
    private var emailFocused: Bool {
        focusedField == .email
    }
    private var passwordFocused: Bool {
        focusedField == .password
    }
    
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        VStack(alignment: .leading){
            
            BackButton {
                //back
                focusedField = nil
                withAnimation {
                    vm.updateState(to: .initial)
                }

            }

            
            Text("Log in")
                .font(Font.custom("Poppins-Medium", size: 28, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .padding(.vertical)
            
            Text("Email")
                .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            TextInputView(text: $email, isFocused: emailFocused)
                .focused($focusedField, equals: .email)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .password
                }
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                        focusedField = .email
                    })
//                    focusedField = .email
                }
            
            Text("Password")
                .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            SecuredTextInputView(text: $password, isFocused: passwordFocused)
                .focused($focusedField, equals: .password)
                .textContentType(.password)
                .submitLabel(.done)
                .onSubmit {
                    print("Done")
                }
                
            Spacer()
            
            FilledButton(label: "Log in", color: Color(AppColor.DARKEST_BLUE)) {
                print("login")
            }
        }
        .padding(.horizontal)
    }
}

