//
//  LocalDataSourceDI.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 27/07/2022.
//

import Foundation

class LocalSourceDI {
    
    func localDependencies() -> SignupViewModel {
        
        let localDataSource = LocalDataSource()
        
        let getCountriesCallingCode = GetCountriesCallingCodeUseCase(localDataSource: localDataSource)
        
        let vm = SignupViewModel(getCallingCodeUseCase: getCountriesCallingCode)
        
        return vm
    }
}
