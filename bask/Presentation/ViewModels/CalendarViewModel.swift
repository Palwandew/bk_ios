//
//  CalendarViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 04/10/2022.
//

import Foundation

class CalendarViewModel: ObservableObject {
    
    private let repository: CalendarRepositoryProtocol
    
    @Published var state: ScreenState = .loading
    
    public private(set) var bookedDays: [Date] = []
    public private(set) var availableDays: [Date] = []
    public private(set) var unavailableDays: [Date] = []
    
    init(repo: CalendarRepositoryProtocol){
        self.repository = repo
        getCalendar(for: "93807af9-3ae9-42cb-8154-0fdf5df674e2")// get this from view
    }
    
    func getCalendar(for facilityID: String){
        
        let year = Calendar.current.component(.year, from: Date())
        let startDate = Calendar.current.date(from: DateComponents(year: year, month: 1, day: 1))
        let endDate = Calendar.current.date(from: DateComponents(year: year + 1, month: 1, day: 1))
        guard let startDate = startDate, let endDate = endDate else {
            return
        }
        repository.fetchCalendarForFacility(with: facilityID, from: startDate, to: endDate) { [weak self] result in
            switch result {
            case .success(let days):
                
                self?.toDates(days)
                
                DispatchQueue.main.async {
                    self?.state = .success
                }
                
            case .failure(_):
                DispatchQueue.main.async {
                    self?.state = .failed
                }
            }
        }
    }
    
    private func toDates(_ days: [CalendarDay]) {
        
        for day in days {
            if day.status == .booked {
                
                let date = DateFormatter.check.date(from: day.date)
                if let date = date {
                    
                    bookedDays.append(Calendar.current.startOfDay(for: date))
                }

            }
            
            if day.status == .available {
                let date = DateFormatter.check.date(from: day.date)
                if let date = date {
                    
                    availableDays.append(Calendar.current.startOfDay(for: date))
                }
            }
            
            if day.status == .unavailable {
                let date = DateFormatter.check.date(from: day.date)
                if let date = date {
                    
                    unavailableDays.append(Calendar.current.startOfDay(for: date))
                }
            }
        }
    }
}

