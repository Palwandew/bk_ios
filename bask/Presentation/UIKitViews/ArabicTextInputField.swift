//
//  ArabicTextInputField.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/08/2022.
//

import SwiftUI

struct ArabicTextInputField: UIViewRepresentable {
    
    
    
    typealias UIViewType = ArabicTextField
    @Binding var text: String
    
    
    func makeUIView(context: Context) -> ArabicTextField {
        let arabicInputField = ArabicTextField()
        arabicInputField.borderStyle = .none
        arabicInputField.placeholder = "Arabic Name"
        arabicInputField.font = UIFont(name: "Poppins-Regular", size: 16)
        arabicInputField.delegate = context.coordinator
        arabicInputField.returnKeyType = .done
        arabicInputField.makeTextWritingDirectionRightToLeft(self)
        arabicInputField.keyboardType = .default
        //arabicInputField.returnKeyType = .done
        
        
        return arabicInputField
    }
    
    func updateUIView(_ uiView: ArabicTextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        var parent: ArabicTextInputField
        
        init(_ textField: ArabicTextInputField) {
            self.parent = textField
        }
        
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
            
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.appending(string)
            parent.text = newString
            
            return true
            
            
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            print("TextField Should Return")
            textField.resignFirstResponder()
            return true
        }
        
//        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//            let allowedCharacters = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXUZ")
//            let characterSet = CharacterSet(charactersIn: string)
//            return allowedCharacters.contains(string)(of: characterSet)
//        }
        
    }
    
    
}

class ArabicTextField: UITextField {
    
    
    override var textInputMode: UITextInputMode? {
        UITextInputMode.activeInputModes.filter
        { $0.primaryLanguage == "ar" }.first ?? super.textInputMode }
    
    
}


//struct ArabicTextInputField_Previews: PreviewProvider {
//    static var previews: some View {
//        ArabicTextInputField()
//    }
//}
