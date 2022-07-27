//
//  SignupViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 11/05/2022.
//

import Foundation

class SignupViewModel: ObservableObject {
    
    
    private let getCountriesCallingCodeUseCase: GetCountriesCallingCodeUseCase
    
    //MARK: - Properties for signup step-1
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var city: String = ""
    @Published var willShowEmailInputScreen = false
    @Published var navigate: Bool = false
    @Published var isValid: Bool = true
    
    //MARK: - Properties for signup step-2
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var willShowVerifyPhoneScreen = false
    
    
    //MARK: - Properties for signup step-3
    @Published var selectedCallingCodeCountry = Country(code: "+92", name: "Pakistan")
    
    //MARK: - Error indicators
    @Published var isValidFirstName: Bool = true
    @Published var isValidEmail: Bool = true
    @Published var isValidPassword: Bool = true
    
    //MARK: - Properties for calling code screen
    @Published var countries: [Country] = []
    
    
    init(getCallingCodeUseCase: GetCountriesCallingCodeUseCase){
        self.getCountriesCallingCodeUseCase = getCallingCodeUseCase
    }
    
    func validateUserFullName(){
        if self.firstName.isEmpty || self.firstName.count < 2{
            isValidFirstName = false
        } else {
            isValidFirstName = true
            willShowEmailInputScreen = true
        }
    }
    
    func validateUserEmailAndPassword(){
        if self.email.isEmpty {
            isValidEmail = false
            return
        }
        if self.password.isEmpty {
            isValidPassword = false
            return
        } else {
            isValidEmail = true
            isValidPassword = true
            willShowVerifyPhoneScreen = true
        }
        
    }
    
    func getCountriesCallingCode(){
        getCountriesCallingCodeUseCase.getCountriesCallingCode { countries in
            print(countries)
            DispatchQueue.main.async {
                self.countries = countries
            }
        }
    }
    
}
