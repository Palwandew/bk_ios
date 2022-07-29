//
//  HorizontalSwipe.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 30/07/2022.
//

import SwiftUI

struct HorizontalSwipe: ViewModifier {
    
    var onLeftSwipe: () -> ()
    var onRightSwipe: () -> ()
    
    func body(content: Content) -> some View {
        content
            .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                        .onEnded({ value in
                
                switch(value.translation.width, value.translation.height) {
                case (...0, -30...30):  onLeftSwipe() //print("left swipe")
                case (0..., -30...30):  onRightSwipe()//print("right swipe")
                default:  print("no clue")
                }
            }))
    }
}

extension View {
    func onHorizontalSwipe(onLeft onLeftSwipe: @escaping () -> (), onRight onRightSwipe: @escaping () -> ()) -> some View {
        modifier(HorizontalSwipe(onLeftSwipe: onLeftSwipe, onRightSwipe: onRightSwipe))
    }
}
