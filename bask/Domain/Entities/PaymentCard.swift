//
//  PaymentCard.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 26/09/2022.
//

import Foundation

struct PaymentCard {
    
    let id: Int
    let type: CardType
    let number: String
}

enum CardType: String {
    case master = "Mastercard"
    case visa = "Visa"
}
