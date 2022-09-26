//
//  GetWalletStatusUsecase.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 26/09/2022.
//

import Foundation

class GetWalletStatusUsecase {
    private let repo: WalletRepositoryProtocol
    
    init(_ repo: WalletRepositoryProtocol){
        self.repo = repo
    }
    
    func getWalletStatus(completion: @escaping (Result<Wallet, Error>) -> Void){
        repo.getWallet(completion: completion)
    }
}
