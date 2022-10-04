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
    
    private var facilityDates: [CalendarDayViewModel] = []
    public private(set) var bookedDays:[Date] = []
    var availableDays: [Date] = []
    var unavailableDays: [Date] = []
    
    init(repo: CalendarRepositoryProtocol){
        self.repository = repo
        getCalendar(for: "93807af9-3ae9-42cb-8154-0fdf5df674e2")
    }
    
    func getCalendar(for facilityID: String){
        
        let year = Calendar.current.component(.year, from: Date())
        // Get the first day of next year
        
        guard let startDate = Calendar.current.date(from: DateComponents(year: year, month: 1, day: 1)) else { return }
        
        
        guard let endDate = Calendar.current.date(from: DateComponents(year: year + 1, month: 1, day: 1)) else { return }
        
        repository.fetchCalendarForFacility(with: facilityID, from: startDate, to: endDate) { [weak self] result in
            switch result {
            case .success(let days):
                
                self?.generateDates(days)
            
                
                DispatchQueue.main.async {
                    print("main queue")
//                    self?.availableDays = availableDays ?? []
//                    self?.unavailableDays = unavailableDays ?? []
                    self?.state = .success
                }
                
            case .failure(let error):
                print("Error 0ccurred \(error)")
            }
        }
    }
    
    private func generateDates(_ days: [CalendarDay]) {
        
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
    
//
//    private func apped(_ day: String,to array: [Date]){
//        let date = DateFormatter.check.date(from: day)
//        if let date = date {
//
//            array.append(Calendar.current.startOfDay(for: date))
//        }
//    }
    
    private func filterList(_ days: [CalendarDay], condition status: Status) -> [CalendarDayViewModel] {
        let booked = days.filter{ $0.status == status}
        
        let mapped = booked.map(CalendarDayViewModel.init)
        
        return mapped
    }
    
//    private func mapDaysToAppropiateList(_ days: [CalendarDay]){
//        
//        let filteredList = filterList(days, condition: .booked)
//        
//        DispatchQueue.main.async {
//            self.bookedDays = filteredList
//        }
//    }
}


struct CalendarDayViewModel {
    private let day: CalendarDay
    
    init(_ day: CalendarDay){
        self.day = day
    }
    
    var price: Int? {
        self.day.price
    }
    
    var status: Status {
        self.day.status
    }
    
    var date: Date? {
        
        guard let date = DateFormatter.check.date(from: self.day.date) else {
            return nil
        }
        return Calendar.current.startOfDay(for: date)
        
    }
}
