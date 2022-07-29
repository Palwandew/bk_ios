//
//  FirstResponderTextField.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 27/07/2022.
//

import SwiftUI

struct FirstResponderTextField: UIViewRepresentable {
    
    typealias UIViewType = UITextField
    
    let tag: Int
    @Binding var becomeFirstResponder: Bool
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        textField.font = UIFont(name: "Poppins-Medium", size: 20)
        textField.textColor = .darkText
        textField.tag = self.tag
        textField.delegate = context.coordinator
        textField.keyboardType = .numberPad
        
        textField.autocorrectionType = .no
        
        return textField
    }
    
    func updateUIView(_ textField: UITextField, context: Context) {
        if self.becomeFirstResponder {
            DispatchQueue.main.async {
                textField.becomeFirstResponder()
                self.becomeFirstResponder = false
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: FirstResponderTextField
        
        init(_ textField: FirstResponderTextField) {
            self.parent = textField
        }
        
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
            print(string)
            parent.text = string
            //parent.text = textField.text ?? ""
            
            let maxLength = 1
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            
            
            return newString.count <= maxLength
            
            
        }
    }
}



//struct FirstResponderTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        FirstResponderTextField()
//    }
//}
