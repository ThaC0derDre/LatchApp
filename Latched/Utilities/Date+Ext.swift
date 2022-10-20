//
//  Date+Ext.swift
//  Latched
//
//  Created by Andres Gutierrez on 9/24/22.
//

import Foundation

extension Date {
    var twoDaysOut : Date {
        Calendar.autoupdatingCurrent.date(byAdding: .day, value: 2, to: self) ?? self
    }
    
    
    var displayDate: String {
        self.formatted(.dateTime.weekday(.wide).month().day())
    }
    
    var displayMonth: String {
        self.formatted(.dateTime.month(.wide))
    }
    
    var displayDayOfWeek: String {
        self.formatted(.dateTime.weekday(.wide).day())
    }
}


