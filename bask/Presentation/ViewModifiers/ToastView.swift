//
//  ToastView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 30/08/2022.
//

import SwiftUI

struct ToastView<ToastContent: View>: ViewModifier {
    
    @Binding var isShowing: Bool // set this to show/hide the dialog
    
    let toastContent: ToastContent
    
    
    init(isShowing: Binding<Bool>,
         backgroundColor: Color? = nil,
         @ViewBuilder content: () -> ToastContent) {
        _isShowing = isShowing
        self.toastContent = content()
        

    }
    
    func body(content: Content) -> some View {
        // wrap the view being modified in a ZStack and render dialog on top of it
        ZStack {
            content
                
            if isShowing {
                VStack{
                    Spacer()
                    
                    toastContent
                    
                }.onAppear {
                    print("appear toast")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.isShowing.toggle()
                    }
                }
            }
        }
    }
}

extension View {
    func toast<Content: View>(
        isShowing: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        
        
        modifier(ToastView(isShowing: isShowing, content: content))
    }
}
