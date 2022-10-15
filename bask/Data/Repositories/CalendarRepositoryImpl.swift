//
//  CalendarRepositoryImpl.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 04/10/2022.
//

import Foundation

class CalendarRepositoryImpl: CalendarRepositoryProtocol {
    
    
    
    let header = ["x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhZTI2N2U4LTY1Y2MtNGM2ZC05NDhhLTU1MThhOGJmZWIzNiIsImlhdCI6MTY2NTg2NDM0OSwiZXhwIjoxNjY2Mjk2MzQ5fQ.Nwg2LF8QWo32Rt_9x4IakexkcdU3Zpf-RoHchpo-cHE", "Content-Type":"application/json; charset=utf-8"]
    
    func fetchCalendarForFacility(with facilityID: String, from startDate: Date, to endDate: Date, completion: @escaping (Result<[CalendarDay], Error>) -> Void) {
        
        let facilityID = URLQueryItem(name: "facilityId", value: facilityID)
        let startDate = URLQueryItem(name: "startDate", value: DateFormatter.check.string(from: startDate))
        let endDate = URLQueryItem(name: "endDate", value: DateFormatter.check.string(from: endDate))
        
        let queryItems = [facilityID, startDate, endDate]
        
        let endPoint = Endpoints(path: "calendar", queryItems: queryItems)
        
        URLSession.shared.sendRequest(endpoint: endPoint, requestType: .get, headers: header, body: nil, responseModel: GetFacilityCalendarResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data.calendar))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func updateFacilityDays(_ body: UpdatedFacilityCalendarDays, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = Endpoints(path: "calendar")
        
        print("Body \(body)")
        URLSession.shared.sendUpdateRequest(endpoint: endpoint, requestType: .post, headers: header, body: body) { result in
            switch result {
            case .success(_):
                completion(.success("successful"))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
