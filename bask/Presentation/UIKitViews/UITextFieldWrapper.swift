//
//  UITextFieldWrapper.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 17/10/2022.
//

import SwiftUI



struct UIKitWrappedTextField: View {
    
    @Binding var text: String
    let placeHolder: String
    let returnButton: UIReturnKeyType
    var inputLanguageIdentifier: String = "en"
    let tag: Int
    @Binding var error: Bool
    @State private var didStartEditing: Bool = false
    @State private var helperTextColor: Color = Color(AppColor.LIGHT_VOILET)
    var body: some View {
        
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading){
                
                UITextfieldWrapper(text: $text, placeholder: placeHolder, inputLanguageIdentifier: inputLanguageIdentifier, tag: tag, returnKeyType: returnButton, error: $error, didStartEditing: $didStartEditing)
                    .frame(height: UIScreen.main.bounds.height * 0.08)
                
                if !text.isEmpty{
                    withAnimation {
                        Text(placeHolder)
                            .font(.custom("Poppins-Regular", size: 12))
                            .foregroundColor(error ? Color(AppColor.RED): helperTextColor)
                            .background(Color.white)
                            .offset(x: 8, y: -8)
                            .animation(.spring(), value: text)
                            .onChange(of: didStartEditing) { isEditing in
                                if isEditing {
                                    helperTextColor = Color(AppColor.LIGHT_VOILET)
                                } else {
                                    helperTextColor = Color(AppColor.GREY)
                                }
                            }
                    }

                        
                }
            }
            
            if error {
                Text("This field cannot be empty")
                    .font(.custom("Poppins-Regular", size: 12))
                    .foregroundColor(error ? Color(AppColor.RED): Color(AppColor.LIGHT_VOILET))
            }
        }
    }
}


struct UITextfieldWrapper: UIViewRepresentable {
    
    typealias UIViewType = CustomTextField
    @Binding var text: String
    let placeholder: String
    var inputLanguageIdentifier: String = "en"
    let tag: Int
    let returnKeyType: UIReturnKeyType
    @Binding var error: Bool
    @Binding var didStartEditing: Bool
    
    func makeUIView(context: Context) -> CustomTextField {
        let textField = CustomTextField(frame: .zero)
        textField.primaryLanguage = inputLanguageIdentifier
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor(red: 0.741, green: 0.753, blue: 0.827, alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.autocorrectionType = .no
        textField.tag = tag
        //textField.text = text
        textField.autocapitalizationType = .none
        textField.font = UIFont(name: "Poppins-Regular", size: 16)
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            .font: UIFont(name: "Poppins-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16.0)
        ])

        textField.delegate = context.coordinator
        textField.returnKeyType = returnKeyType
        textField.keyboardType = .default
        
        return textField
    }
    
    func updateUIView(_ uiView: CustomTextField, context: Context) {
        if error {
            uiView.layer.borderColor = UIColor(red: 0.859, green: 0.185, blue: 0.142, alpha: 1).cgColor
            
        }
        
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {

        var parent: UITextfieldWrapper
        private let focusedColor: CGColor = UIColor(red: 0.439, green: 0.467, blue: 0.847, alpha: 1).cgColor
        private let errorColor: CGColor = UIColor(red: 0.859, green: 0.185, blue: 0.142, alpha: 1).cgColor
        private let defaultColor: CGColor = UIColor(red: 0.741, green: 0.753, blue: 0.827, alpha: 1).cgColor
        
        init(_ parent: UITextfieldWrapper){
            self.parent = parent
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {

            if self.parent.error {
                updateBorderStyle(of: textField, with: errorColor, cornerRadis: 10, width: 2)
            } else {
                self.parent.didStartEditing = true
                updateBorderStyle(of: textField, with: focusedColor, cornerRadis: 10, width: 2)
            }
        }
        
        
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let currentString = (textField.text ?? "")
            
            if isPrimaryInputLanguageArabic(textField) {
                
                if string.isArabic || string.elementsEqual(" "){
                    
                    updateInputString(currentString, string)
                    updateBorderStyle(of: textField, with: focusedColor, cornerRadis: 10, width: 2)
                    return true
                } else {
                    handleBackspace(for: textField, currentString, string)
                    return string.isEmpty
                }
            } else {
                
                if !string.isArabic && !string.isEmpty {
                    updateInputString(currentString, string)
                    updateBorderStyle(of: textField, with: focusedColor, cornerRadis: 10, width: 2)
                    
                    return true
                }
                else {
                    handleBackspace(for: textField, currentString, string)
                    return string.isEmpty
                }
            }
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            
            if self.parent.error {
                updateBorderStyle(of: textField, with: errorColor, cornerRadis: 10, width: 2)
            } else {
                self.parent.didStartEditing = false
                updateBorderStyle(of: textField, with: defaultColor, cornerRadis: 10, width: 1)
            }
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            
        // Try to find next responder
              if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
                 nextField.becomeFirstResponder()
              } else {
                 // Not found, so remove keyboard.
                 textField.resignFirstResponder()
              }
              // Do not add a line break
              return false
           
            
        }
        
        private func updateBorderStyle(of textField: UITextField, with color: CGColor, cornerRadis: CGFloat, width: CGFloat) {
            textField.layer.borderColor = color
            textField.layer.borderWidth = width
            textField.layer.cornerRadius = cornerRadis
        }
        
        private func isPrimaryInputLanguageArabic(_ textField: UITextField) -> Bool {
            if let lang = textField.textInputMode?.primaryLanguage {
                return lang == "ar"
            }
            return false
        }
        
        private func updateInputString(_ currentString: String, _ string: String){
            let newString = currentString.appending(string)
            
            DispatchQueue.main.async {
                self.parent.error = false
                self.parent.text = newString
                
            }
        }
        
        private func handleBackspace(for textField: UITextField, _ currentString: String, _ string: String){
            if string.isEmpty {
                let newString = currentString.dropLast()
                
                if newString.isEmpty {
                    updateBorderStyle(of: textField, with: errorColor, cornerRadis: 10, width: 2)
                    self.parent.error = true
                }
                DispatchQueue.main.async {
                    self.parent.text = String(currentString.dropLast())
                }
            }
        }
    }
}


final class CustomTextField: UITextField {
    
    var primaryLanguage = "en"
    
    override var textInputMode: UITextInputMode? {
        UITextInputMode.activeInputModes.first(where: {$0.primaryLanguage?.prefix(2) ?? "" == primaryLanguage}) ?? super.textInputMode
    }
}

extension String {
    var isArabic: Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", "(?s).*\\p{Arabic}.*")
        return predicate.evaluate(with: self)
    }
}
