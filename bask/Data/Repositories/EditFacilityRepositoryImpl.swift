//
//  EditFacilityRepositoryImpl.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 23/10/2022.
//

import Foundation

class EditFacilityRepositoryImpl: EditFacilityRepositoryProtocol {
    
    
    let header = ["x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhZTI2N2U4LTY1Y2MtNGM2ZC05NDhhLTU1MThhOGJmZWIzNiIsImlhdCI6MTY2NjI4NzU0MCwiZXhwIjoxNjY2NzE5NTQwfQ.FI7w7VuTnaHFPVrOhgybsVBgr6EyM8YuJ85TiLVXy-Y", "Content-Type":"application/json; charset=utf-8"]
    
    func getRoomsData(for facilityID: String, completion: @escaping (Result<Facility, Error>) -> Void) {
        
//        let facilityId = URLQueryItem(name: "facilityId", value: facilityID)
//        let amenityType = URLQueryItem(name: "amenityType", value: "rooms")
//        let queryParameters: [URLQueryItem] = [facilityId, amenityType]
//        let endPoint = Endpoints(path: "facilityservice/singlefacility", queryItems: queryParameters)
//        
//        URLSession.shared.sendRequest(endpoint: endPoint, requestType: .get, headers: header, body: nil, responseModel: OwnerFacilityRoomsModel.self) { result in
//            switch result {
//            case .success(let response):
//                completion(.success(response.data.otherData.dotFacilityEntity()))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
    }
}
