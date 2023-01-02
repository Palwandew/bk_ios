//
//  EmailAvailabilityModel.swift
//  bask
//
//  Created by MapMac on 03/01/2023.
//

import Foundation

struct EmailAvailabilityModel : Codable {
    let isAvailable: Bool
    let reason: String?
}
