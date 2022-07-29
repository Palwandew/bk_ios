//
//  OTPInput.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 29/07/2022.
//

import SwiftUI

struct OTPInput: View {
    

    
    @Binding var firstDigit: String
    @State var firstInput: Bool = false
    @Binding var secondDigit: String
    @State var secondInput: Bool = false
    @Binding var thirdDigit: String
    @State var thirdInput: Bool = false
    @Binding var fourthDigit: String
    @State var fourthInput: Bool = false
    @Binding var fifthDigit: String
    @State var fifthInput: Bool = false
    @Binding var sixthDigit: String
    @State var sixthInput: Bool = false
    
    var body: some View {
        
        
        HStack {
            
            DigitInput(text: $firstDigit, responder: $firstInput, tag: 1)
            .onChange(of: firstDigit) { newValue in
                print("New Value 1st--> \(newValue)")
                if newValue.count == 1 {
                    firstInput.toggle()
                    secondInput.toggle()
                }
            }
            
            DigitInput(text: $secondDigit, responder: $secondInput, tag: 2)
            .onChange(of: secondDigit) { newValue in
                print("New Value 2nd --> \(newValue)")
                if newValue.count == 1 {
                    secondInput.toggle()
                    thirdInput.toggle()
                }
            }
            
            DigitInput(text: $thirdDigit, responder: $thirdInput, tag: 3)
            .onChange(of: thirdDigit) { newValue in
                print("New Value 3rd--> \(newValue)")
                if newValue.count == 1 {
                    thirdInput.toggle()
                    fourthInput.toggle()
                }
            }
            
            DigitInput(text: $fourthDigit, responder: $fourthInput, tag: 4)
            .onChange(of: fourthDigit) { newValue in
                print("New Value 4th--> \(newValue)")
                if newValue.count == 1 {
                    fourthInput.toggle()
                    fifthInput.toggle()
                }
            }
            
            DigitInput(text: $fifthDigit, responder: $fifthInput, tag: 5)
            .onChange(of: fifthDigit) { newValue in
                print("New Value 5th--> \(newValue)")
                if newValue.count == 1 {
                    fifthInput.toggle()
                    sixthInput.toggle()
                }
            }
            
            DigitInput(text: $sixthDigit, responder: $sixthInput, tag: 6)
            .onChange(of: sixthDigit) { newValue in
                print("New Value 6th--> \(newValue)")
                if newValue.count == 1 {
                    fifthInput = false
                    secondInput = false
                    thirdInput = false
                    fourthInput = false
                    fifthInput = false
                    sixthInput = false
                }
            }
        }
        
        
    }
}

struct DigitInput: View{
    @Binding var text: String
    @Binding var responder: Bool// onEditingChanged: (Bool) -> ()
    let tag: Int
    var body: some View {
        
            ZStack{
                FirstResponderTextField( tag: tag, becomeFirstResponder: $responder, text: $text)
                    .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .headline))
                    .padding(.leading, 12)
                    
            }.foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 9, style: .continuous).fill(.white))
                .frame(width: (UIScreen.main.bounds.width - (64 + 40)) / 6, height: 40)
                .shadow(radius: 2)
        
    }
}

//struct OTPInput_Previews: PreviewProvider {
//    static var previews: some View {
//        OTPInput()
//    }
//}
