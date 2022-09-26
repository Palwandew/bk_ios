//
//  AddPaymentMethodResponse.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 26/09/2022.
//

import Foundation

import Foundation

// MARK: - PaymentMethodsResponse
struct AddPaymentMethodResponse: Codable {
    let data: AddPaymentMethodData
    let error: Bool
    let message: String
}

// MARK: - AddPaymentMethod
struct AddPaymentMethodData: Codable {
    let response: DataFromPayTab
}

// MARK: - DataFromPayTab
struct DataFromPayTab: Codable {
    let tranRef, tranType, cartID, cartDescription: String
    let cartCurrency, cartAmount: String
    let callback: String
    let responseReturn: String
    let redirectURL: String
    let customerDetails: CustomerDetails
    let serviceID, profileID, merchantID: Int
    let trace: String

    enum CodingKeys: String, CodingKey {
        case tranRef = "tran_ref"
        case tranType = "tran_type"
        case cartID = "cart_id"
        case cartDescription = "cart_description"
        case cartCurrency = "cart_currency"
        case cartAmount = "cart_amount"
        case callback
        case responseReturn = "return"
        case redirectURL = "redirect_url"
        case customerDetails = "customer_details"
        case serviceID = "serviceId"
        case profileID = "profileId"
        case merchantID = "merchantId"
        case trace
    }
}

// MARK: - CustomerDetails
struct CustomerDetails: Codable {
    let name, email, phone, city: String
}
