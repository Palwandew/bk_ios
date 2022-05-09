//
//  ColorExtension.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/05/2022.
//

import Foundation
import SwiftUI


extension Color {
    init(_ hex: UInt, alpha: Double = 1){
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}
