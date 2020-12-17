//
//  Date+Extensions.swift
//  Expense Tracker
//
//  Created by isEmpty on 17.12.2020.
//

import Foundation

extension Date {
    ///Returns 00:00 of the given day.
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    ///Returns 23:59 of the given day.
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    ///Returns first day of given day month.
    var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: startOfDay)
        return Calendar.current.date(from: components)!
    }
    
    ///Returns last day of given day month.
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth)!
    }
}
