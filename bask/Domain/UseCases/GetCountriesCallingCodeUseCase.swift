//
//  GetCountriesCallingCodeUseCase.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 27/07/2022.
//

import Foundation


class GetCountriesCallingCodeUseCase {
    private let localDataSource: CountryCallingCodeProtocol
    
    init(localDataSource: CountryCallingCodeProtocol){
        self.localDataSource = localDataSource
    }
    
    func getCountriesCallingCode(completion: @escaping ([Country]) -> Void){
        localDataSource.getCallingCodesForAllCountries { countries in
            completion(countries)
        }
    }
    
}
