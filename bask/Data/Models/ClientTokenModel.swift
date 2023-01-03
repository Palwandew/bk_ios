//
//  ClientTokenModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 03/01/2023.
//

import Foundation

struct ClientToken: Codable {
    let accessToken: String
    let refreshToken: String
}
