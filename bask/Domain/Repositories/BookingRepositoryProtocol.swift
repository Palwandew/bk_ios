//
//  BookingRepositoryProtocol.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 29/09/2022.
//

import Foundation

protocol BookingRepositoryProtocol {
    
    func getUpcomingBookings(completion: @escaping (Result<[UpcomingBooking], RequestError>) -> Void)
    
    func declineBooking(with bookingID: String, completion: @escaping (Result<String, Error>) -> Void)
    
    func acceptBooking(with bookingID: String, completion: @escaping (Result<String, Error>) -> Void)
    
    func getPresentBookings(completion: @escaping (Result<[PresentBookingOld], Error>) -> Void)
    
    func getPastBookings(completion: @escaping (Result<[PastBookingOld], Error>) -> Void)
    
}
