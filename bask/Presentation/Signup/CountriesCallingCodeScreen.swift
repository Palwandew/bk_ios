//
//  CountriesCallingCodeScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 27/07/2022.
//

import SwiftUI

struct CountriesCallingCodeScreen: View {
    
    @EnvironmentObject var signUpViewModel: SignupViewModel
    //@StateObject var signUpViewModel = SignupViewModel(getCallingCodeUseCase: GetCountriesCallingCodeUseCase(localDataSource: LocalDataSource()))
    
    @State var selectedCountry: Country = Country(code: "+92", name: "Pakistan")
    
    var onCloseTapped: () -> ()
    
    var body: some View {
        VStack{
            HStack{
                
                Image(systemName: "xmark")
                    .resizable()
                    .foregroundColor(.gray)
                    .frame(width: 15, height: 15)
                    .onTapGesture {
                        onCloseTapped()
                    }
                
                Spacer()
                
                Rectangle()
                    .fill(.gray)
                    .frame(width: UIScreen.main.bounds.width * 0.10, height: 3)
                
                Spacer()
            }.padding()
            
            HStack {
                Text("Country Codes")
                    .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                .font(Font.custom("Poppins-Medium", size: 20.0, relativeTo: .headline))
                .padding(.top)
                Spacer()
            }.padding(.leading)
            
            ScrollView{
                LazyVStack(alignment: .leading){
                    ForEach(signUpViewModel.countries, id:\.self) { country in
                        
                        if signUpViewModel.selectedCallingCodeCountry == country {
                            CallingCodeItem(country: country, isSelected: true)
                                
                        } else {
                            CallingCodeItem(country: country, onItemTapped: {
                                signUpViewModel.selectedCallingCodeCountry = country
                            })
                                
                        }
                        
                    }
                }
            }
        }
    }
    
    private struct CallingCodeItem: View {
        
    
        var country: Country
        var isSelected: Bool = false
        var onItemTapped: (() -> ())? = nil
        
        var body: some View {
            HStack{
                Text("\(country.code) - \(country.name)")
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    .font(Font.custom("Poppins-Medium", size: 16.0, relativeTo: .body))
                    .padding(.vertical, 8)
                if isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                        .foregroundColor(Color(AppColor.ACCENT_GREEN))
                        
                }
                
            }
            .padding(8)
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


//struct CountriesCallingCodeScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        CountriesCallingCodeScreen()
//    }
//}
