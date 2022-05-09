//
//  User.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/05/2022.
//

import Foundation

public struct User{
    private let id: String?
    private let fullName: String?
    private let city: String?
    
    init(id: String?, fullName: String?, city: String?){
        self.id = id
        self.fullName = fullName
        self.city = city
    }
}
