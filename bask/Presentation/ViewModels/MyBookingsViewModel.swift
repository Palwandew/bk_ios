//
//  MyBookingsViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 31/07/2022.
//

import Foundation

class MyBookingsViewModel: ObservableObject {
    @Published var isLoadingAlertPresented: Bool = false
    @Published var screenState: MyBookingsScreenState = .loading
    
    init(){
        print("MyBookingsViewModel -> init()")
    }
    
    func updateState() {
        print("updating state")
        if screenState == .success {
            //changeState(state: .loading)
            print("sccuss state")
        }
        
        if screenState == .loading {
            print("loading state")
            changeState(state: .success)
        }
//        else {
//        changeState(state: .success)
//        }
        //changeState(state: .failed)
    }
    
    private func changeState(state: MyBookingsScreenState) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.screenState = state
        }
    }
    
    deinit{
        print("MyBookingsViewModel -> deInit()")
    }
}

enum MyBookingsScreenState {
    case loading
    case success
    case failed
}