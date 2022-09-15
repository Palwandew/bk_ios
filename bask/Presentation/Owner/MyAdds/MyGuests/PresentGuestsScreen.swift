//
//  PresentGuestsScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 15/09/2022.
//

import SwiftUI

struct PresentGuestsScreen: View {
    private let guests: [String] = []
    
    init(){
        print("Guest present screen")
    }
    
    var body: some View {
        
        if guests.isEmpty{
            
            EmptyState(illustration: "empty_guest_illustration", message: "You don't have any guests at this moment.")
        }
        else {
            
            ScrollView{
                
                LazyVStack {
                    ForEach(0..<guests.underestimatedCount, id:
                                \.self){ index in
                        MyGuestListItem(name: guests[index])
                    }
                }
            }
        }
    }
}


struct PresentGuestsScreen_Previews: PreviewProvider {
    static var previews: some View {
        PresentGuestsScreen()
    }
}
