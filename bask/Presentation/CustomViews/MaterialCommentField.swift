//
//  MaterialCommentField.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 16/09/2022.
//

import SwiftUI

struct MaterialCommentField: UIViewRepresentable {
    typealias UIViewType = UITextView
    
    @Binding var text: String
    @Binding var resignFirstResponder: Bool
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView(frame: .zero)
         
        textView.font = UIFont(name: "Poppins-Regular", size: 16)
        textView.backgroundColor = .clear
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.delegate = context.coordinator
        textView.isUserInteractionEnabled = true
        textView.inputAccessoryView = createDoneLabel()
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        
        if resignFirstResponder {
            uiView.resignFirstResponder()
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator($text)
    }
     
    class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
     
        init(_ text: Binding<String>) {
            self.text = text
        }
     
        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.text.wrappedValue = textView.text
            }
        }
    }
    
    
    
    private func createDoneLabel() -> UILabel {
        
        let label = UILabel(frame: .zero)
        label.text = "Done"
        
        return label
    }
    
}
