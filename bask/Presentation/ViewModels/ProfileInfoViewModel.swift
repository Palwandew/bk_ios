//
//  ProfileInfoViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 28/09/2022.
//

import Foundation

class ProfileInfoViewModel: ObservableObject {
    
    private let useCase: GetUserProfileDetailsUsecase
    
    @Published var user: UserViewModel = UserViewModel(User(fullName: "asf", email: "asf", password: "asfd", type: .guest))
    
    @Published var isCurrentPasswordVerified: Bool = false 
    @Published var isCurrentPasswordValid: Bool = true
    
    
    
    init(_ useCase: GetUserProfileDetailsUsecase){
        
        self.useCase = useCase
        
        getDetails()
    }
    
    private func getDetails(){
        
        useCase.getUserProfileDetails { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    
                case .failure(_):
                    print("Error")
                case .success(let user):
                    self?.user = UserViewModel(user)
                }
            }
        }
        
    }
    
    func verifyPassword(_ password: String) -> String {
        
        if password.isEmpty {
            isCurrentPasswordValid = false
            return "Please enter a password"
        } else {
        
        
        useCase.verifyPassword(password) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                        
                    case .failure(_):
                        print("Error")
                    case .success(let isValid):
                        if isValid {
                            self?.isCurrentPasswordVerified.toggle()
                        }
                        self?.isCurrentPasswordValid = isValid
                    }
                }
            }
            
            return "Password is incorrect"
        }
    }
    
}

class ChangePasswordViewModel: ObservableObject {
    
    private let useCase: GetUserProfileDetailsUsecase
    
    
    @Published var isCurrentPasswordVerified: Bool = false
    @Published var isCurrentPasswordValid: Bool = true
    @Published var showSpinner: Bool = false
    @Published var toast: ToastViewModel = ToastViewModel()
    @Published var dimissScreen: Bool = false
    
    init(_ useCase: GetUserProfileDetailsUsecase){
        
        self.useCase = useCase
        
    }
    
    
    func verifyPassword(_ password: String) -> String {
        
        if password.isEmpty {
            isCurrentPasswordValid = false
            return "Please enter a password"
        } else {
        showSpinner = true
            self.isCurrentPasswordValid = true 
        useCase.verifyPassword(password) { [weak self] result in
            
                DispatchQueue.main.async {
                    self?.showSpinner.toggle()
                    switch result {
                        
                    case .failure(_):
                        print("Error")
                    case .success(let isValid):
                        if isValid {
                            self?.isCurrentPasswordVerified.toggle()
                        }
                        self?.isCurrentPasswordValid = isValid
                    }
                }
            }
            
            return "Password is incorrect"
        }
    }
    
    func updatePassword(_ newPassword: String) {
        if newPassword.isEmpty || newPassword.count < 8 {
            return
        } else {
            
            showSpinner = true
            useCase.updatePassword(newPassword) { [weak self] result in
                
                    DispatchQueue.main.async {
                        self?.showSpinner.toggle()
                        switch result {
                            
                        case .failure(_):
                            print("Error")
                            self?.toast.prepare(for: .failure, with: "Error occured: Please try again.")
                        case .success(let isValid):
                            print("change \(isValid)")
                            self?.toast.prepare(for: .success, with: "Password updated successfully.")
                        }
                        self?.toast.show()
                        self?.objectWillChange.send()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            self?.dimissScreen = true 
                        }
                    }
                }
        }
    }
    
}

struct UserViewModel {
    
    private let user: User
    
    var fullName: String
    var city: String
    var phone: String
    var email: String
    
    init(_ user: User){
        self.user = user
        
        self.fullName = self.user.fullName 
        self.city = self.user.city ?? ""
        self.phone = self.user.mobileNumber ?? ""
        self.email = self.user.email 
    }
    
//    var fullName: String {
//        self.user.fullName ?? ""
//    }
//
//    var city: String {
//        self.user.city ?? ""
//    }
//
//    var phone: String {
//        self.user.mobileNumber ?? ""
//    }
//
//    var email : String {
//        self.user.email ?? ""
//    }
    
}
