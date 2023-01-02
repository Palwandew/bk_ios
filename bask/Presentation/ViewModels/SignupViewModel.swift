//
//  SignupViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 11/05/2022.
//

import Foundation

class SignupViewModel: ObservableObject {
    
    private let signUpUseCase: SignupUseCase
    
    @Published var steps: [SignUpSteps] = [.email]
    @Published var currentStep: SignUpSteps = .email
    @Published var signUpForm: SignUpFormModel = SignUpFormModel(fullName: "", city: "", email: "", password: "", phoneNumber: "", userType: UserType.owner)
    @Published var ownerTypeAccout = true
    @Published var signUpSuccessful: Bool = false
    @Published var showAlert: Bool = false
    enum SignUpSteps: String, CaseIterable {
        case email
        case password
        case name
        
    }
    var isButtonEnabled: Bool {
        return validateButtonStatus()
    }
    
    init(signUpUseCase: SignupUseCase){
        self.signUpUseCase = signUpUseCase
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
    
    func onButtonTapped(){
        
        if currentStep == .name {
            //flowVM.isSignedIn.toggle()
            showAlert.toggle()
            let user = User(fullName: signUpForm.fullName, email: signUpForm.email, password: signUpForm.email, type: signUpForm.userType)
            signUpUseCase.signUp(user) { [weak self] result in
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        // save user creds to keychain
                        
                        self?.showAlert.toggle()
                        self?.signUpSuccessful.toggle()
                        
                    case .failure(let failure):
                        print("Failed -> \(failure.customMessage)")
                        self?.showAlert.toggle()
                    }
                }
            }
        } else {
            next()
        }
    }
    
    private func createAccount(){
        signUpSuccessful.toggle()
        
    }
    
    func validateEmailAddressWhileTyping(_ char: String)  {
        
        if char.isEmpty {
            signUpForm.emailHelperText = .empty
        } else {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.com"
            
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



