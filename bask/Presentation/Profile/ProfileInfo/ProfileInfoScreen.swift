//
//  ProfileInfoScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 24/09/2022.
//

import SwiftUI

struct ProfileInfoScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @State var englishLanguageSelected: Bool = true
    @State var text: String = "Palwandew"
    @State var isValid: Bool = true
    let errorMessage: LocalizedStringKey = LocalizedStringKey("error")
    
    @State var isEditModeOff: Bool = true
    
    
    var body: some View {
        VStack(alignment: .leading){
            
//            Text("Profile info")
//                .font(.custom("Poppins-Medium", size: 26))
//                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    Group {
                        MaterialTextField(text: $text, isValid: $isValid, errorMessage: errorMessage, placeHolder: "Full name")
                    
                        MaterialTextField(text: $text, isValid: $isValid, errorMessage: errorMessage, placeHolder: "City (Optional)")
                        
                        MaterialPhoneNumberField(text: $text, isValid: $isValid, errorMessage: "error", placeHolder: "123-456-789", countryCallingCode: "+996") {
                            print("hi")
                        }
                        
                        MaterialTextField(text: $text, isValid: $isValid, errorMessage: errorMessage, placeHolder: "Email")
                        
                    }.disabled(isEditModeOff)
                    
                    HStack{
                        Image(systemName: "lock.fill")
                        
                        Text("Change password")
                            .font(.custom("Poppins-Regular", size: 16))
                            .foregroundColor(Color(AppColor.DARKEST_BLUE))
                            .onTapGesture {
                                
                            }
                    }
                    
                    Divider()
                        .padding(.vertical)
                    
                    Text("Language")
                        .font(.custom("Poppins-Regular", size: 20))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    
                    LanguageSelector(label: "Arabic", isSelected: !englishLanguageSelected, onTapped: {
                        englishLanguageSelected.toggle()
                    })
                    
                    LanguageSelector(label: "English", isSelected: englishLanguageSelected, onTapped: {
                        englishLanguageSelected.toggle()
                    })
                }
                .padding(.vertical)
                .padding(1)
            }
            
            if !isEditModeOff {
                FilledButton(label: "Save changes", color: Color(AppColor.DARKEST_BLUE)) {
                    isEditModeOff.toggle()
                }
            }
            
        }.padding(.horizontal)
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Profile info")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action : {
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color(AppColor.GREY))

                    }
                }
                
                
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Text(isEditModeOff ? "Edit" : "")
                            .font(Font.custom("Poppins-Light", size: 16.0))
                            .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                            .onTapGesture {
                                //UIApplicationHelper.popToRootView()
                                isEditModeOff.toggle()
                            }
                    }
                
            })
    }
}

struct ProfileInfoScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileInfoScreen()
        ProfileInfoScreen().environment(\.locale, .init(identifier: "ar") )
            .environment(\.layoutDirection, .rightToLeft)
    }
}

//struct ExtractedView: View {
//    var body: some View {
//        Circle().stroke(Color(AppColor.MAIN_TEXT_DARK), lineWidth: 4)
//            .overlay(
//                Circle().fill(Color(AppColor.ACCENT_GREEN))
//                    .padding()
//            )
//    }
//}

struct LanguageSelector: View {
    
    let label: String
    let isSelected: Bool
    let onTapped: () -> Void
    
    var body: some View {
        HStack {
            Text(LocalizedStringKey(label))
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .fontWeight(.regular)
            
            Spacer()
            
            RadioButton(checked: isSelected)
                .onTapGesture {
                    if !self.isSelected{
                        onTapped()
                    }
                }
            
        }
    }
}
