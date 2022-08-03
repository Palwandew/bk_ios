//
//  AmenityDescriptionCounter.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 03/08/2022.
//

import SwiftUI

struct AmenityDescriptionCounter: View {
    
    let label: String
    @Binding var counter: Int
    @Binding var valid: Bool
    @Binding var text: String
    let error: LocalizedStringKey
    
    var body: some View {
        
        VStack{
            AmenityCounterView(counter: $counter, label: label) {
                print("-")
                counter -= 1
            } onIncrease: {
                print("+")
                counter += 1
            }//.padding(.bottom)
            
            MaterialTextField(text: $text, isValid: $valid, errorMessage: (error), placeHolder: "Description (Optional)")
        }
    }
}
