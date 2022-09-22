//
//  Offer.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 21/09/2022.
//

import Foundation

struct Offer {
    
    var facilityID: String
    var originalPrice: Int
    var discount: String
    var type: String
    var startDate: Date?
    var endDate: Date?
    var validDiscount: Bool {
        return true
    }
    
    var newPrice: Int {
        return updatedPrice()
    }
    
    var formattedStartDate: String {
        return formatDate(startDate)
    }
    
    var formattedEndDate: String {
        return formatDate(endDate)
    }
    
    func hasDiscountAmountAdded() -> Bool {
        return !discount.isEmpty
    }
    
    func hadValidOfferDates() -> Bool {
        guard let _ = startDate, let _ = endDate else {
            return false
        }
        return true
    }
    
    private func updatedPrice() -> Int{
        return originalPrice - (Int(discount) ?? 0)
    }
    
    private func formatDate(_ date: Date?) -> String {
        if let date = date {
            return DateFormatter.test.string(from: date)
        } else {
            return ""
        }
    }
}
