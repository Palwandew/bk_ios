//
//  LocalDataSource.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 27/07/2022.
//

import Foundation

class LocalDataSource: CountryCallingCodeProtocol {
    
    func getCallingCodesForAllCountries(completion: @escaping ([Country]) -> Void) {
        
        do {
            if let filePath = Bundle.main.path(forResource: "countries_code", ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                
                let jsonData = try JSONDecoder().decode(Countries.self, from: data)
                completion(jsonData.countries)
            }
        } catch {
            print("error: \(error)")
        }
        
        
//        guard let url = Bundle.main.url(forResource: "countries_code", withExtension: "json") else {
//            print("File not found")
//            return
//        }
//
//
//        let data = try? Data(contentsOf: url)
//        let countries = try? JSONDecoder().decode(Countries.self, from: data!)
//
//        if let url = Bundle.main.url(forResource: "countries_code", withExtension: "json"),
//           let data = try? Data(contentsOf: url) {
//            let decoder = JSONDecoder()
//
//            if let jsonData = try? decoder.decode(Countries.self, from: data) {
//                completion(jsonData.coutries)
//            } else {
//                let count: [Country] = [Country(code: "+1", name: "USA"), Country(code: "+92", name: "Pak")]
//
//                completion(count)
//            }
//        }
    }
}
