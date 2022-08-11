//
//  Room.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 10/08/2022.
//

import Foundation

class Room: Hashable, Identifiable {
    let id: UUID = UUID()
    var width: String = ""
    var length: String = ""
    var validLength: Bool = true
    var validWidth: Bool = true
    
    static func == (lhs: Room, rhs: Room) -> Bool {
        return (lhs.width == rhs.width && lhs.length == rhs.length && lhs.validWidth == rhs.validWidth && lhs.validLength == rhs.validLength)
    }
    
    
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            //hasher.combine(name) If userId was not unique, we could have added this.
            
            // And if that still doesn't do it, consider generating a random UUID for
            // each instance and that can serve as the sole hashing property.
        }
    
    
}
