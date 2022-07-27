//
//  CountryCallingCodeRepoProtocol.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 27/07/2022.
//

import Foundation


protocol CountryCallingCodeProtocol {
    
    func getCallingCodesForAllCountries(completion: @escaping ([Country]) -> Void)
    
}
