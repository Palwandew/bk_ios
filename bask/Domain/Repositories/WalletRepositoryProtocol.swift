//
//  WalletRepositoryProtocol.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 26/09/2022.
//

import Foundation

protocol WalletRepositoryProtocol{
    
    func getWallet(completion: @escaping (Result<Wallet, Error>) -> Void)
}
