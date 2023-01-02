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
    func userSignedIn(_ value: Bool){
        isSignedIn = value
    }
}
