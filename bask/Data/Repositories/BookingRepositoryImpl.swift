//
//  BookingRepositoryImpl.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 29/09/2022.
//

import Foundation

class BookingRepositoryImpl: BookingRepositoryProtocol {
    
    let header = ["x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhZTI2N2U4LTY1Y2MtNGM2ZC05NDhhLTU1MThhOGJmZWIzNiIsImlhdCI6MTY2NDY4ODE3MywiZXhwIjoxNjY1MTIwMTczfQ.hDybTvFXGEoUXU-Y4qWuZwe1DTsJNWtD2aQSiYmwoCE", "Content-Type":"application/json; charset=utf-8"]
    
    func getUpcomingBookings(completion: @escaping (Result<[UpcomingBookingOld], Error>) -> Void) {
        
        let endpoint = Endpoints(path: "booking/upcoming")
        
        URLSession.shared.sendRequest(endpoint: endpoint, requestType: .get, headers: header, body: nil, responseModel: OwnerUpcomingBookingResponse.self) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                completion(.success(response.data.upcomingBookings))
            }
        }
    }
    
    func declineBooking(with bookingID: String, completion: @escaping (Result<String, Error>) -> Void) {
        let urlQueryParameter = URLQueryItem(name: "booking_id", value: bookingID)
        let endpoint = Endpoints(path: "booking/reject", queryItems: [urlQueryParameter])
        
        URLSession.shared.sendRequest(endpoint: endpoint, requestType: .get, headers: header, body: nil, responseModel: DeclineBookingResponse.self) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(_):
                completion(.success("Successful"))
            }
        }
    }
    
    func acceptBooking(with bookingID: String, completion: @escaping (Result<String, Error>) -> Void) {
        let urlQueryParameter = URLQueryItem(name: "booking_id", value: bookingID)
        let endpoint = Endpoints(path: "booking/accept", queryItems: [urlQueryParameter])
        
        URLSession.shared.sendRequest(endpoint: endpoint, requestType: .get, headers: header, body: nil, responseModel: DeclineBookingResponse.self) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(_):
                completion(.success("Successful"))
            }
        }
    }
    
    func getPresentBookings(completion: @escaping (Result<[PresentBooking], Error>) -> Void){
        let endpoint = Endpoints(path: "booking/present")
        
        URLSession.shared.sendRequest(endpoint: endpoint, requestType: .get, headers: header, body: nil, responseModel: OwnerPresentBookingsResponse.self) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                completion(.success(response.data.presentBookings))
            }
        }
    }
    
    func getPastBookings(completion: @escaping (Result<[PastBooking], Error>) -> Void){
        let endpoint = Endpoints(path: "booking/past")

        URLSession.shared.sendRequest(endpoint: endpoint, requestType: .get, headers: header, body: nil, responseModel: OwnerPastBookingsResponse.self) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                completion(.success(response.data.pastBookings))
            }
        }
    }
}
