//
//  Wallet.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 26/09/2022.
//

import Foundation

struct Wallet{
    
    let availableAmount: Int
    let pendingAmount: Int
    var amountAvailability: Float {
        
        return Float(availableAmount / (availableAmount + pendingAmount))
    }
}
