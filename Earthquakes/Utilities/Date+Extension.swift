//
//  Date+Extension.swift
//  Earthquakes
//
//  Created by Praveen on 8/10/22.
//

import Foundation

struct DateFormats {
    static let apiDate = "yyyy-MM-dd"
    static let eventDate = "EEEE, MMM d, yyyy h:mm a"
}

extension DateFormatter {
    fileprivate static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        return formatter
    }()
}

extension Date {
    
    // Gives date in requested format Usage: Date().string(format: "yyyy-MM-dd") -> "2021-09-16"
    func string(_ format: String = DateFormats.apiDate) -> String {
        DateFormatter.formatter.dateFormat = format
        return DateFormatter.formatter.string(from: self)
    }
    
    func date(byAddingDays days: Int) -> Date {
        var diff = DateComponents()
        diff.day = days
        return Calendar.current.date(byAdding: diff, to: self)!
    }
}
