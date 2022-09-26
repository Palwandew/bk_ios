//
//  GetWalletStatusResponse.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 26/09/2022.
//

import Foundation

// MARK: - GetWalletStatusResponse
struct GetWalletStatusResponse: Codable {
    let data: WalletData
    let error: Bool
    let message: String
    
    func dotWalletEntity() -> Wallet {
        return Wallet(availableAmount: data.wallet.balance, pendingAmount: data.wallet.pending)
    }
}

// MARK: - WalletData
struct WalletData: Codable {
    let wallet: WalletModel
}

// MARK: - WalletModel
struct WalletModel: Codable {
    let id: Int
    let userID: String
    let balance, pending, totalPaid, totalEarned: Int

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case balance, pending
        case totalPaid = "total_paid"
        case totalEarned = "total_earned"
    }
}
