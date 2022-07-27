//
//  CountryCode.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 27/07/2022.
//

import Foundation

struct Countries: Decodable {
    let countries: [Country]
}


struct Country: Decodable, Hashable  {
    let code: String
    let name: String
}
