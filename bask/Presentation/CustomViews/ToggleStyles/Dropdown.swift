//
//  Dropdown.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 04/08/2022.
//

import SwiftUI

struct Dropdown: MenuStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        
        VStack{
            Menu(configuration)
            
            Text("heh")
        }

        
    }
    
}
