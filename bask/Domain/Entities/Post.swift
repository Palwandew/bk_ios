//
//  Post.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/05/2022.
//

import Foundation


public struct Post: Identifiable{
    public let userId: Int?
    public let id: Int?
    public let title: String?
    public let body: String
    
    public init(userId: Int?, id: Int?, title: String?, body: String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
}
