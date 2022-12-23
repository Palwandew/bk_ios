//
//  SignUpScreen.swift
//  bask
//
//  Created by MapMac on 21/12/2022.
//

import SwiftUI

struct SignUpScreen: View {
    
    var animation: Namespace.ID
    @ObservedObject var flowVM: FlowSelectorViewModel
    @StateObject var model: SignupViewModel = SignupViewModel()
    @FocusState private var emailFocused: Bool
    @FocusState private var passwordFocused: Bool
    @FocusState private var nameFocused: Bool
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                
                BackButton {
                    performBackAction()
                }
                
                Text("Create account")
                    .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    .padding(.vertical)
                
                switch model.currentStep {
                case .email:
                    renderInputField(text: $model.signUpForm.email, isSecured: false, label: "What's your email?", helperText: model.signUpForm.emailHelperText.rawValue, focusState: $emailFocused)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .submitLabel(.next)
                        .textInputAutocapitalization(.never)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        .onChange(of: model.signUpForm.email, perform: { userInputChar in
                            model.validateEmailAddressWhileTyping(userInputChar)
                        })
                        .onSubmit {
                            model.onEmailSubmitTapped()
                        }
                case .password:
                    renderInputField(text: $model.signUpForm.password, isSecured: true, label: "Create a password", helperText: model.signUpForm.passwordHelperText.rawValue, focusState: $passwordFocused)
                        .keyboardType(.default)
                        .textContentType(.newPassword)
                        .submitLabel(.next)
                        .onChange(of: model.signUpForm.password, perform: { userInputChar in
                            model.validateMinimumPasswordCharactersLimit(userInputChar)
                        })
                        .onSubmit {
                        }
                    
                case .name:
                    
                    renderInputField(text: $model.signUpForm.fullName, isSecured: false, label: "What's your name?", helperText: model.signUpForm.nameHelperText.rawValue, focusState: $nameFocused)
                        .keyboardType(.default)
                        .textContentType(.name)
                        .submitLabel(.done)
                        .textInputAutocapitalization(.words)
//                        .onChange(of: model.signUpForm.fullName, perform: { userInputChar in
//                            print(userInputChar)
//                            model.validateEmailAddressWhileTyping(userInputChar)
//                        })
                        .onSubmit {
                            model.onNameSubmitTapped()
                        }
                    
                    Text("What's your account type?")
                        .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .title))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                        .padding(.top)
                    
                    UserSelectionView(isOwnerSelected: $model.ownerTypeAccout)
                        .frame(height: 50)
                }
                Spacer()
                
                FilledButton(label: model.currentStep == .name ? "Create account" : "Next", color: model.isButtonEnabled ? Color(AppColor.DARKEST_BLUE) : Color(AppColor.MAIN_TEXT_LIGHT)) {
                    withAnimation {
                        if model.currentStep == .name {
                            flowVM.isSignedIn.toggle()
                            
                        } else {
                            model.next()
                        }
                    }
                }.disabled(!model.isButtonEnabled)
                //.matchedGeometryEffect(id: "btn", in: animation)
            }
            
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
    }
    
    private func performBackAction() {
        if model.currentStep == .email {
            emailFocused = false 
            withAnimation {
                flowVM.updateState(to: .initial)
            }
        } else {
            model.back()
        }
    }
    
    private func renderInputField(text: Binding<String>, isSecured: Bool, label: String, helperText: String, focusState: FocusState<Bool>.Binding) -> some View {
        VStack(alignment: .leading){
            
            Text(label)
                .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            if isSecured {
                SecuredTextInputView(text: text, isFocused: focusState.wrappedValue)
                    .focused(focusState)
                    .onAppear{
                        
                        if text.wrappedValue.isEmpty {
                            
                            focusState.wrappedValue = true
                            
                        }
                    }
            } else {
                TextInputView(text: text, isFocused: focusState.wrappedValue)
                    .focused(focusState)
                    .onAppear{
                        
                        if text.wrappedValue.isEmpty {
                            
                            focusState.wrappedValue = true
                            
                        }
                    }
            }
            Text(helperText)
                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
        }
    }
}

//
//struct SignUpScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpScreen()
//    }
//}
