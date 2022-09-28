//
//  VerifyPasswordScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 28/09/2022.
//

import SwiftUI

struct VerifyPasswordScreen: View {
    @Environment(\.presentationMode) var presetationMode
    @StateObject private var model: ChangePasswordViewModel = ChangePasswordViewModel(GetUserProfileDetailsUsecase(repo: UserRepositoryImpl()))
    
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var isEdit: Bool = false
    @State private var isValid: Bool = true
    @State private var verified: Bool = false
    
    @State private var currentPasswordInputError: LocalizedStringKey? = nil
    @Binding var dimissScreen: Bool 
    
    var body: some View {
        VStack(alignment: .leading){
            
            if !model.isCurrentPasswordVerified {
                PasswordInputView(title: "Verify password", subtitle: "Please verify your current password to proceed", errorMessage: currentPasswordInputError, password: $currentPassword, isEdit: $isEdit, isValid: $model.isCurrentPasswordValid)
                    .transition(.slide)
            } else {
                PasswordInputView(title: "New password", subtitle: "Please create a new password", password: $newPassword, isEdit: $isEdit, isValid: $isValid)
                    .transition(.slide)
            }
            
           
            Spacer()
            
            if model.showSpinner {
                HStack {
                    Spacer()
                    Spinner()
                    Spacer()
                }
            }
            
            Spacer()
            
            FilledButton(label: !model.isCurrentPasswordVerified ? "Verify" : "Save password", color: Color(AppColor.DARKEST_BLUE)) {
                print("Verify")
                UIApplicationHelper.dimissKeyboard()
                if model.isCurrentPasswordVerified {
                    model.updatePassword(newPassword)
                    
                    if model.dimissScreen {
                        presetationMode.wrappedValue.dismiss()
                    }
                }else {
                withAnimation {

                     let message =  model.verifyPassword(currentPassword)
                    self.currentPasswordInputError = LocalizedStringKey(message)
                }
                }
            }
            
        }.padding()
            .toast(isShowing: $model.toast.willShow) {
                Toast(message: model.toast.message, style: model.toast.style)
            }
    }
}



struct PasswordInputView: View {
    
    let title: String
    let subtitle: String
    var errorMessage: LocalizedStringKey? = nil
    @Binding var password: String
    @Binding var isEdit: Bool
    @Binding var isValid: Bool
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(LocalizedStringKey(title))
                .font(.custom("Poppins-Medium", size: 26))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            //.animation(.easeInOut, value: verified)
                .transition(.move(edge: .leading))
            
            Text(LocalizedStringKey(subtitle))
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
            //.animation(.easeInOut, value: verified)
                .transition(.move(edge: .trailing))
            
            MaterialSecureField(text: $password, isEditing: $isEdit, isValid: $isValid, errorMessage: errorMessage ?? "valid_password", placeHolder: "New password")
            //.animation(.easeInOut, value: verified)
                .transition(.slide)
        }.padding(.top)
    }
}
