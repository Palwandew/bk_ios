//
//  WalletViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 26/09/2022.
//

import Foundation

class WalletViewModel: ObservableObject{
    private let useCase: GetWalletStatusUsecase
    
    @Published var wallet: Wallet = Wallet(availableAmount: 0, pendingAmount: 0)
    
    @Published var state: ScreenState = .loading
    
    init(_ useCase: GetWalletStatusUsecase){
        self.useCase = useCase
        getWalletStatus()
    }
    
    
    private func getWalletStatus() {
        useCase.getWalletStatus { [weak self] result in
            DispatchQueue.main.async {
                
                switch result{
                
                case .success(let wallet):
                    self?.wallet = wallet
                    self?.state = .success
                case .failure(_):
                    print("Error")
                    self?.state = .failed
                }
                    
            }
        }
    }
    
}
