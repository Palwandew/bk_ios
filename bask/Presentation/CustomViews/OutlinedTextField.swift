//
//  OutlinedTextField.swift
//  bask
//
//  Created by MapMac on 07/12/2022.
//

import SwiftUI

struct WiggleView: View {
    @State private var offset: CGFloat = 0
    
    var body: some View {
        VStack {
            Text("Wiggle Me!")
                .padding()
                .background(Color.green)
                .foregroundColor(Color.white)
                .font(.largeTitle)
                .offset(x: offset, y: 0)
                .onTapGesture {
                    withAnimation(Animation.easeInOut(duration: 0.1)) {
                        self.offset = 6
                        self.offset = -self.offset
                        //self.offset = 0
                    }
                }
        }
    }
}


struct OutlinedTextField_Previews: PreviewProvider {
    static var previews: some View {
        WiggleView()
    }
}
