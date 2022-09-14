//
//  onLeftSwipe.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 30/07/2022.
//
import SwiftUI

struct LeftSwipe: ViewModifier {
    
    var onSwipe: () -> ()
    
    func body(content: Content) -> some View {
        content
            .highPriorityGesture(DragGesture(minimumDistance: 30, coordinateSpace: .local)
                        .onEnded({ value in
                
                switch(value.translation.width, value.translation.height) {
                            case (...0, -30...30):  onSwipe() 
                            default:  print("no clue")
                        }
            }))
    }
}

extension View {
    func onLeftSwipe(_ onSwipe: @escaping () -> ()) -> some View {
        modifier(LeftSwipe(onSwipe: onSwipe))
    }
}
