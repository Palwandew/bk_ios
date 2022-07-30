//
//  SpecifiRoundCorner.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 30/07/2022.
//

import SwiftUI

struct SpecificRoundCorner: Shape {
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners
    
    func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
}


struct CornerRadiusStyle: ViewModifier {
    
    var radius: CGFloat
    var corners: UIRectCorner
    
    func body(content: Content) -> some View {
        content
            .clipShape(SpecificRoundCorner(radius: radius, corners: corners))
    }
    
}

extension View {
    func roundCorners(radius: CGFloat, _ corners: UIRectCorner) -> some View {
        modifier(CornerRadiusStyle(radius: radius, corners: corners))
    }
}
