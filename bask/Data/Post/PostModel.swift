//
//  PostModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/05/2022.
//

import Foundation


public struct PostModel: Codable {
    
    public let userId: Int?
    public let id: Int?
    public let title: String?
    public let body: String
    
    
    // DOT: Data Object Transfer
    public func dotPostEntity() -> Post {
        return Post(userId: userId, id: id, title: title, body: body)
    }
}
