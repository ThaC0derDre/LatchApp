//
//  TimeEntity+CoreDataProperties.swift
//  Latched!
//
//  Created by Andres Gutierrez on 10/22/22.
//
//

import Foundation
import CoreData


extension TimeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimeEntity> {
        return NSFetchRequest<TimeEntity>(entityName: "TimeEntity")
    }

    @NSManaged public var duration: String?
    @NSManaged public var timeEnded: String?
    @NSManaged public var dateAdded: Date?
    @NSManaged public var day: DayEntity?

    public var wrappedDuration: String {
        duration ?? "Unknown Duration"
    }
    
    public var wrappedTimeEnded: String {
        timeEnded ?? "Unknown Time Ended"
    }
    
    public var wrappedDateAdded: Date {
        dateAdded ?? Date.now
    }
    
    
}

extension TimeEntity : Identifiable {

}
