//
//  SignupViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 11/05/2022.
//

import Foundation

class SignupViewModel: ObservableObject {
    
    
    @Published var steps: [SignUpSteps] = [.email]
    @Published var currentStep: SignUpSteps = .email
    @Published var signUpForm: SignUpFormModel = SignUpFormModel(fullName: "", city: "", email: "", password: "",
                                                                 phoneNumber: "")
    var isButtonEnabled: Bool {
        return validateButtonStatus()
    }
    @Published var ownerTypeAccout = true
    enum SignUpSteps: String, CaseIterable {
        case email
        case password
        case name
        
    }
    
    func next() {
        pushNextState()
    }
    
    func back() {
        performBackAction()
    }
    
    func onEmailSubmitTapped() {
        if signUpForm.email.isEmpty {
            signUpForm.emailHelperText = .empty
        }
    }
    
    func onNameSubmitTapped() {
        //
    }
    
    func validateEmailAddressWhileTyping(_ char: String)  {
        
        if char.isEmpty {
            signUpForm.emailHelperText = .empty
        } else {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: char)
            
            if emailPred {
                signUpForm.emailHelperText = .valid
            } else {
                signUpForm.emailHelperText = .invalid
            }
        }
    }
    
    func validateMinimumPasswordCharactersLimit(_ char: String){
        if char.isEmpty {
            signUpForm.passwordHelperText = .empty
        } else {
            if char.count < 8 {
                signUpForm.passwordHelperText = .invalid
            } else {
                signUpForm.passwordHelperText = .valid
            }
        }
    }
    
    func validateMinimumNameLimit(_ char: String){
        if char.isEmpty {
            signUpForm.nameHelperText = .empty
        } else {
            signUpForm.nameHelperText = .valid
        }
    }
    
    private func validateButtonStatus() -> Bool {
        switch currentStep {
        case .email:
            return !signUpForm.email.isEmpty && (signUpForm.emailHelperText == .valid)
        case .password:
            return !signUpForm.password.isEmpty && (signUpForm.passwordHelperText == .valid)
        case .name:
            return !signUpForm.fullName.isEmpty && (signUpForm.nameHelperText == .valid)
        }
    }
    
    private func pushNextState(){
        if !steps.contains(currentStep.next()) {
            currentStep = currentStep.next()
            steps.append(currentStep)
            
        }
    }
    
    private func performBackAction() {
        guard steps.count > 1 else { return }
        steps.removeAll(where: {$0 == currentStep})
        currentStep = currentStep.previous()
    }
}



