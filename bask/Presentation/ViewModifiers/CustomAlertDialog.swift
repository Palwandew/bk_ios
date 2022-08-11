//
//  CustomAlertDialog.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 31/07/2022.
//

import SwiftUI

struct CustomAlertDialog<DialogContent: View>: ViewModifier {
    @Binding var isShowing: Bool // set this to show/hide the dialog
    
    let dialogContent: DialogContent
    let cornerRadius: CGFloat?
    let backgroundColor: Color?
    
    
    init(isShowing: Binding<Bool>,
         cornerRadius: CGFloat? = nil,
         backgroundColor: Color? = nil,
         @ViewBuilder dialogContent: () -> DialogContent) {
        _isShowing = isShowing
        self.dialogContent = dialogContent()
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        

    }
    
    func body(content: Content) -> some View {
        // wrap the view being modified in a ZStack and render dialog on top of it
        ZStack {
            content
                
            if isShowing {
                // the semi-transparent overlay
                Rectangle().foregroundColor(Color.black.opacity(0.6))
                // the dialog content is in a ZStack to pad it from the edges
                // of the screen
                ZStack {
                    dialogContent
                        .background(
                            RoundedRectangle(cornerRadius: cornerRadius ?? 8)
                                .foregroundColor(backgroundColor ?? .white))
                }.padding(40)
            }
        }
    }
}

extension View {
    func alertDialog<Content: View>(
        isShowing: Binding<Bool>, cornerRadius: CGFloat? = nil,
        backgroundColor: Color? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        modifier(CustomAlertDialog(isShowing: isShowing, cornerRadius: cornerRadius, backgroundColor: backgroundColor, dialogContent: content))
    }
}

