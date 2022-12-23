//
//  FlowSelectorViewModel.swift
//  bask
//
//  Created by MapMac on 20/12/2022.
//

import Foundation

class FlowSelectorViewModel: ObservableObject {
    @Published var isFirstTime: Bool = true
    @Published var isSignedIn: Bool = false
    
    enum SignInSignUpSelectionState {
        case initial
        case signUp
        case login
    }
    @Published var state: SignInSignUpSelectionState = .initial
    
    func updateState(to newState: SignInSignUpSelectionState){
        state = newState
    }

}
