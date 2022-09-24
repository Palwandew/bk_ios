//
//  MessageDeliveryIndicator.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 24/09/2022.
//

import SwiftUI

struct MessageDeliveryIndicator: View {
    
    @State private var status: Status = .readByEndUser
    
    var body: some View {
        
            
            switch status {
            case .reachedServer:
                Image(systemName: "checkmark")
                    .foregroundColor(.gray)
                    
            case .deliveredToEndUser:
                Image(systemName: "checkmark")
                
                    .overlay(
                        Image(systemName: "checkmark")
                            .offset(x: 6)
                        
                    )
                    .foregroundColor(.gray)
            case .readByEndUser:
                Image(systemName: "checkmark")
                    
                    .overlay(
                        Image(systemName: "checkmark")
                            .offset(x: 6)
                        
                    )
                    .foregroundColor(Color(AppColor.ACCENT_GREEN))
            }
    }
    
    private enum Status{
        case reachedServer
        case deliveredToEndUser
        case readByEndUser
    }
}

struct MessageDeliveryIndicator_Previews: PreviewProvider {
    static var previews: some View {
        MessageDeliveryIndicator().previewLayout(.sizeThatFits)
    }
}
