//
//  AmenityPaidCounter.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 03/08/2022.
//

import SwiftUI

struct AmenityPaidCounter: View {
    
    let label: String = "Wifi"
    @State var counter: Int = 0
    @State var valid: Bool = true
    @State var text: String = "ho"
    let error: LocalizedStringKey = "valid_description"
    
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

struct AmenityPaidCounter_Previews: PreviewProvider {
    static var previews: some View {
        AmenityPaidCounter()
    }
}

struct PricePerUnit: View {
    
    let label: String
    @Binding var length: String
    @Binding var width: String
    @Binding var validLength: Bool
    @Binding var validWidth: Bool
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(label)
                .font(Font.custom("Poppins-Regular", size: 16.0))
            
            HStack {
                MaterialLengthField(text: $length, isValid: $validLength, errorMessage: "valid_room_length", placeHolder: "x-meters")
                
                Image(systemName: "multiply")
                
                MaterialLengthField(text: $width, isValid: $validWidth, errorMessage: "valid_room_length", placeHolder: "y-meters")
            }
        }
    }
}
