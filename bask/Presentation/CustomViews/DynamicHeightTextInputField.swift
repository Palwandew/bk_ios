//
//  MessageInputField.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 24/09/2022.
//

import SwiftUI


struct MessageInputField: View {
    
    @Binding var text: String
    @State private var dynamicHeight: CGFloat = 100
    @State private var showPlaceholder: Bool = true
    @State private var shouldResignFirstResponder: Bool = false
    let onSend: () -> Void
    
    var body: some View{
        HStack {
            DynamicHeightTextInputField(text: $text, height: $dynamicHeight, resignFirstResponder: $shouldResignFirstResponder)
                .frame(minHeight: dynamicHeight, maxHeight: dynamicHeight)
                .padding(.leading)
           
            
            Image(systemName: "paperplane.fill")
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .rotationEffect(.degrees(45))
                .padding(.trailing, 4)
                .onTapGesture {
                    //shouldResignFirstResponder = true
                    onSend()
                }
                
        }
        .padding(4)
        .background(RoundedRectangle(cornerRadius: dynamicHeight == 100 ? 50 : 20).stroke(Color(AppColor.DARKEST_BLUE), lineWidth: 2))
        
    }
}



struct DynamicHeightTextInputField: UIViewRepresentable{
    typealias UIViewType = UITextView
    
    @Binding var text: String
    @Binding var height: CGFloat
    @Binding var resignFirstResponder: Bool
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = UIFont(name: "Poppins-Regular", size: 16)
        textView.backgroundColor = .clear
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .default
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.delegate = context.coordinator
        textView.isUserInteractionEnabled = true
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        
        if text.isEmpty && !uiView.isFirstResponder {
            uiView.text = "Enter you message"
            uiView.textColor = UIColor.lightGray
        }else {
            uiView.text = text
        }
        
        if resignFirstResponder {
            uiView.resignFirstResponder()
            //resignFirstResponder.toggle()
        }
        if uiView.contentSize.height < 150{
            DynamicHeightTextInputField.recalculateHeight(view: uiView, result: $height)
        } else {
            uiView.isScrollEnabled = true 
        }

    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    fileprivate static func recalculateHeight(view: UIView, result: Binding<CGFloat>) {
            let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
            if result.wrappedValue != newSize.height {
                DispatchQueue.main.async {
                    result.wrappedValue = newSize.height // !! must be called asynchronously
                }
            }
        }
     
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: DynamicHeightTextInputField
     
        init(_ parent: DynamicHeightTextInputField) {
            
            self.parent = parent
        }
     
        func textViewDidChange(_ textView: UITextView) {
            if textView.contentSize.height < 150{
                DynamicHeightTextInputField.recalculateHeight(view: textView, result: parent.$height)
            }
            
            DispatchQueue.main.async {
                self.parent.$text.wrappedValue = textView.text
            }
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.resignFirstResponder.toggle()
                
            }
        }
    }
}
