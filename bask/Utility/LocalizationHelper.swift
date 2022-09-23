//
//  DateFormatHelper.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 13/09/2022.
//

import Foundation
import MapKit
import SwiftUI

class LocalizationHelper {
    
    
    func getLocalizedTime(from timeFromServer: String) -> String {
        
        let time = DateFormatter.timeStringToDate.date(from: timeFromServer)
        guard let time = time else {
            return "__"
        }

        let localizedTime = DateFormatter.time.string(from: time)
        
        return localizedTime
    }
    
    func getLocalizedDate(_ date: Date) -> LocalDate {
        
        return generateLocalizedDate(date)
    }
    
    func getLocalizedNumber(_ number: Int) -> String {
        return generateLocalizedString(for: number)
    }
    
    func getLocalizedNumber(from: String) -> String {
        return generateLocalizedString(from: from)
    }
    
    private func generateLocalizedDate(_ date: Date) -> LocalDate {
        let stringDate = getDateString(date: date)
        
        let splitedDate = stringDate.split(separator: " ")
        
        let day = String(splitedDate.first ?? "")
        let month = String(splitedDate[1] )
        let year = String(splitedDate.last ?? "")
        
        let localdate = LocalDate(day: day, month: month, year: year)
        return localdate
        
    }
    
    private func getDateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        formatter.dateFormat = "dd MMMM yyyy"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    private func getDay(date: Date) -> String {
        let calendar = Calendar.autoupdatingCurrent
        return String(calendar.component(.day, from: date))
    }
    
    private func getYear(date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: date)
    }
    
    private func getDateFrom(_ date: String) -> Date {
        let splitedDate = date.split(separator: "-")
        
        let year = Int(splitedDate[0])
        let month = Int(splitedDate[1])
        let day = Int(splitedDate[2])
        
        
        let dateComponents = DateComponents(calendar: Calendar.current,
                                                          year: year,
                                                          month: month,
                                                          day: day,
                                                          hour: 7,
                                                          minute: 0,
                                                          second: 0)
        
        let date = dateComponents.date!
        
        return date
    }
    
    private func generateLocalizedString(for number: Int) -> String {
        let numberToTransform = NSNumber(value: number)
        let formattingStyle = NumberFormatter.Style.none // this will exclude the currency sign from the string.
        let localizedString = NumberFormatter.localizedString(from: numberToTransform, number: formattingStyle)
        
        return localizedString
    }
    
    private func generateLocalizedString(from: String) -> String {
        let formatter = NumberFormatter()
        let stringToTransform = formatter.number(from: from)
        guard let stringToTransform = stringToTransform else {
            return ""
        }

        let formattingStyle = NumberFormatter.Style.none // this will exclude the currency sign from the string.
        let localizedString = NumberFormatter.localizedString(from: stringToTransform, number: formattingStyle)
        
        return localizedString
    }
}


class MapSnapshotter {
    
    var mapType = MKMapType.standard
    
    
    
    func take(size: CGSize) -> UIImage? {
        let options = MKMapSnapshotter.Options()
        
        options.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 24.19970898091148, longitude: 45.11031652737802), span: MKCoordinateSpan(latitudeDelta: 8, longitudeDelta: 22))
        
        options.mapType = .standard
        options.showsBuildings = false
        options.size = size
        
        var imag: UIImage? = nil
        
        let snapshotter = MKMapSnapshotter(options: options)
        
        snapshotter.start(with: .main) { snapshot, error in
            if let _ = error {
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            imag = snapshot.image
        }
        
        return imag
    }
    
    
    
}
