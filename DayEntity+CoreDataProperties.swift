//
//  DayEntity+CoreDataProperties.swift
//  Latched!
//
//  Created by Andres Gutierrez on 10/22/22.
//
//

import Foundation
import CoreData


extension DayEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayEntity> {
        return NSFetchRequest<DayEntity>(entityName: "DayEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var times: NSSet?

    public var wrappedDate: Date {
        date ?? Date.now
    }
    
    public var wrappedTimes: [TimeEntity] {
        let sortedTimes = times as? Set<TimeEntity> ?? []
        
        return sortedTimes.sorted {
            $0.wrappedDateAdded < $1.wrappedDateAdded
        }
    }
    
}

// MARK: Generated accessors for times
extension DayEntity {

    @objc(addTimesObject:)
    @NSManaged public func addToTimes(_ value: TimeEntity)

    @objc(removeTimesObject:)
    @NSManaged public func removeFromTimes(_ value: TimeEntity)

    @objc(addTimes:)
    @NSManaged public func addToTimes(_ values: NSSet)

    @objc(removeTimes:)
    @NSManaged public func removeFromTimes(_ values: NSSet)

}

extension DayEntity : Identifiable {

}
