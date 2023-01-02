//
//  SignInSignUpSelectionViewModel.swift
//  bask
//
//  Created by MapMac on 23/12/2022.
//

import Foundation

class SignInSignUpSelectionViewModel: ObservableObject {
    
    @Published var state: SignInSignUpSelectionState = .initial
    enum SignInSignUpSelectionState {
        case initial
        case signUp
        case login
    }
    
    func updateState(to newState: SignInSignUpSelectionState){
        state = newState
    }
}
