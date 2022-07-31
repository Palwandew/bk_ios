//
//  RightSwipe.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 30/07/2022.
//

import SwiftUI

struct RightSwipe: ViewModifier {
    
    var onSwipe: () -> ()
    
    func body(content: Content) -> some View {
        content
            .gesture(DragGesture(minimumDistance: 30, coordinateSpace: .local)
                        .onEnded({ value in
                if value.translation.width > 0 {
                    // right
                    print("Right")
                    onSwipe()
                    
                }
            }))
    }
}

extension View {
    func onRightSwipe(_ onSwipe: @escaping () -> ()) -> some View {
        modifier(RightSwipe(onSwipe: onSwipe))
    }
}
