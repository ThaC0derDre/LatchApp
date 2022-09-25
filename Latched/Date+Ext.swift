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
}
