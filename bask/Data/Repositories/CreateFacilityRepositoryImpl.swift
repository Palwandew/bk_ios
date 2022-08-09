//
//  CreateFacilityRepositoryImpl.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 10/08/2022.
//

import Foundation

class CreateFacilityReopositoryImpl: CreateFacilityDomainRepoProtocol {
    func addFacilityName(_ data: Data, completion: @escaping (Result<String, Error>) -> Void) {
        
        let url = "https://api.baskapp.co/api/v1/facility"
        
        // Don't forget to change access-token 
        
        URLSession.shared.sendRequest(endpoint: url, requestType: .post, headers: ["x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhZTI2N2U4LTY1Y2MtNGM2ZC05NDhhLTU1MThhOGJmZWIzNiIsImlhdCI6MTY2MDA3MjAyNiwiZXhwIjoxNjYwNTA0MDI2fQ.Xgwu319b3RpHk55jvvAp-UH-SQPL-_UhaTSzc2yPAOE", "Content-Type":"application/json; charset=utf-8"], body: data, responseModel: FacilityCreateName.self) { result in
            switch result {
            case .failure(let error):
                print("error occured \(error.localizedDescription)")
                completion(.failure(error))
                
            case .success(let response):
                completion(.success(response.data.facility.id))
                //completion(response.data.facility.id)
            }
            
        }
    }
    
    func addFacilityRooms(_ data: Data, completion: @escaping (Bool) -> Void) {
        //still need to implement
    }
    
    
}
