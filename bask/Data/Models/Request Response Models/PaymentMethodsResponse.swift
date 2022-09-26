//
//  PaymentMethodsResponse.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 26/09/2022.
//

import Foundation

// MARK: - PaymentMethodsResponse
struct PaymentMethodsResponse: Codable {
    let data: PaymentMethodsData
    let error: Bool
    let message: String
    
    func cards() -> [PaymentCard] {
        return data.cards.map{$0.dotPaymentCardEntity()}
    }
}

// MARK: - PaymentMethodsData
struct PaymentMethodsData: Codable {
    let cards: [PaymentMethodCard]
}

// MARK: - PaymentMethodCard
struct PaymentMethodCard: Codable {
    let id: Int
    let paymentMethod, paymentDescription: String
    
    func dotPaymentCardEntity() -> PaymentCard {
        return PaymentCard(id: id, type: CardType(rawValue: paymentMethod) ?? .master, number: paymentDescription)
    }
}
