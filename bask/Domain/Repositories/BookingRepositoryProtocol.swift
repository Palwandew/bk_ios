//
//  BookingRepositoryProtocol.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 29/09/2022.
//

import Foundation

protocol BookingRepositoryProtocol {
    
    func getUpcomingBookings(completion: @escaping (Result<[UpcomingBooking], Error>) -> Void)
    
}
