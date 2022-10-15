//
//  CalendarRepositoryProtocol.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 04/10/2022.
//

import Foundation

protocol CalendarRepositoryProtocol {
    
    func fetchCalendarForFacility(with facilityID: String, from startDate: Date, to endDate: Date, completion: @escaping (Result<[CalendarDay], Error>) -> Void)
    
    // Update facility calendar days
    func updateFacilityDays(_ body: UpdatedFacilityCalendarDays, completion: @escaping (Result<String, Error>) -> Void)
}
