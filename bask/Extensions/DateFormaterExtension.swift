//
//  DateFormaterExtension.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 21/09/2022.
//

import Foundation

extension DateFormatter {
    
    static var day: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.setLocalizedDateFormatFromTemplate("d")
        //formatter.dateFormat = "MMMM"
        return formatter
    }
    
    static var test: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.setLocalizedDateFormatFromTemplate("dd MMM")
        //formatter.dateFormat = "MMMM"
        return formatter
    }
    
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.setLocalizedDateFormatFromTemplate("MMMM yyyy")
        //formatter.dateFormat = "MMMM"
        return formatter
    }
    
    static var full: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy MM dd"
        return formatter
    }
    
    static var timeStringToDate: DateFormatter {
        let dateFormatter = DateFormatter()
        // When converting string time to date, We need to set the locale.
        //In most cases the best locale to choose is "en_US_POSIX".
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "hh:mm a"

        return dateFormatter
    }
    
    static var time: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        return dateFormatter
    }
}
