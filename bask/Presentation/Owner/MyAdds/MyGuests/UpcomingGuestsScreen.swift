//
//  UpcomingGuestsScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 15/09/2022.
//

import SwiftUI

struct UpcomingGuestsScreen: View {
    private let guests: [String] = []
    
    init(){
        print("Guest upcoming screen")
    }
    
    var body: some View {
        
        if guests.isEmpty{
            
            EmptyState(illustration: "empty_guest_illustration", message: "You are not expecting any guests.")
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

struct UpcomingGuestsScreen_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingGuestsScreen()
    }
}
