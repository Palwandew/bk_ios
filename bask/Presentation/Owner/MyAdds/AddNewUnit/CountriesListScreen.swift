//
//  CountriesListScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/08/2022.
//

import SwiftUI

struct CountriesListScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    //@EnvironmentObject var signUpViewModel: SignupViewModel
    @StateObject var signUpViewModel = SignupViewModel()
    
    @State var selectedCountry: Country = Country(code: "+92", name: "Pakistan")
    @State var searchText: String = ""
    
    //var onCloseTapped: () -> ()
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack {
                
                Spacer()
                
                Image(systemName: "xmark")
                    .resizable()
                    .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    .frame(width: 15, height: 15)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                        //onCloseTapped()
                }
            }//.padding(.trailing)
            
            HStack(alignment: .center){
                
                Image(systemName: "magnifyingglass")
                
                TextField("Where do you live?", text: $searchText)
                    .font(Font.custom("Poppins-Regular", size: 12))
                
                Spacer()
                
                
            }.padding(.vertical)
            
//            ForEach(myFruits.filter({ (fruit: String) -> Bool in
//                     return fruit.hasPrefix(searchText) || searchText == ""
//                 }), id: \.self) { fruit in
//                     Text(fruit)
//                 }
            
            Text("Country")
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            .font(Font.custom("Poppins-Medium", size: 20.0, relativeTo: .headline))
            
//            ScrollView{
//                LazyVStack(alignment: .leading){
//                    ForEach(signUpViewModel.countries.filter({ (country: Country) -> Bool in
//                        return country.name.hasPrefix(searchText) || searchText == ""
//                    }), id:\.self) { country in
//                        
//                        if signUpViewModel.selectedCallingCodeCountry == country {
//                            CallingCodeItem(country: country, isSelected: true)
//                                
//                        } else {
//                            CallingCodeItem(country: country, onItemTapped: {
//                                signUpViewModel.selectedCallingCodeCountry = country
//                            })
//                                
//                        }
//                        
//                    }
//                }
//            }
        }.padding(.horizontal)
            
    }
    
    private struct CallingCodeItem: View {
        
    
        var country: Country
        var isSelected: Bool = false
        var onItemTapped: (() -> ())? = nil
        
        var body: some View {
            HStack{
                Text(country.name)
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    .font(Font.custom("Poppins-Regular", size: 16.0, relativeTo: .body))
                    .padding(.vertical, 8)
                if isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                        .foregroundColor(Color(AppColor.ACCENT_GREEN))
                        
                }
                
            }
            .padding([.top, .bottom, .trailing], 8)
            .background(isSelected ? Color(AppColor.SELECTION_GREY) : .clear)
            .onTapGesture {
                guard let onItemTapped = onItemTapped else {
                    return
                }
                onItemTapped()
            }
        }
    }
}

struct CountriesListScreen_Previews: PreviewProvider {
    static var previews: some View {
        CountriesListScreen()
    }
}
