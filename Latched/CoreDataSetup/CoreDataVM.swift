//
//  CoreDataVM.swift
//  Latched!
//
//  Created by Andres Gutierrez on 10/19/22.
//

import Foundation
import CoreData

class CoreDataVM : ObservableObject {
    @Published var months   = [MonthEntity]()
    @Published var days     = [DayEntity]()
    @Published var times    = [TimeEntity]()
    
    let manager = CoreDataManager.instance
    
    init() {
        getMonths()
        getDays()
        getTimes()
    }
    
    //MARK: - "ADD" Functions
    
    func addMonth(_ month: String) {
        let newMonth = MonthEntity(context: manager.context)
        newMonth.name = month
        save()
    }
    
    func addDay(_ day: String) {
        let newDay = DayEntity(context: manager.context)
        newDay.name = day
        newDay.months = months.last
        save()
    }
    
    func addTime(duration: String, timeEnded: String) {
        let newTime = TimeEntity(context: manager.context)
        newTime.duration = duration
        newTime.timeEnded = timeEnded
        
        newTime.day         = days.last
        newTime.month       = months.last
        save()
    }
    
    //MARK: - "Get" Functions
    
    func getMonths(){
        let request = NSFetchRequest<MonthEntity>(entityName: "MonthEntity")
        do {
            months = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching Months. \(error.localizedDescription)")
        }
    }
    
    func getDays(){
        let request = NSFetchRequest<DayEntity>(entityName: "DayEntity")
        do {
            days = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching Days. \(error.localizedDescription)")
        }
    }
    
    func getTimes(){
        let request = NSFetchRequest<TimeEntity>(entityName: "TimeEntity")
        do {
            times = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching Times. \(error.localizedDescription)")
        }
    }
    
    func getTimes(forDay day: DayEntity){
        // call with (forDay: vm.days.last)
        let request = NSFetchRequest<TimeEntity>(entityName: "TimeEntity")
        let filter = NSPredicate(format: "day == %@", day)
        request.predicate = filter
        do {
            times = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching Times. \(error.localizedDescription)")
        }
    }
    
    //MARK: - Delete Functions
    
    func deleteDay(_ day: DayEntity) {
        manager.context.delete(day)
        save()
    }
    
    func deleteTimes(_ time: TimeEntity){
        manager.context.delete(time)
        save()
    }
    
    func deleteMonth(_ month: MonthEntity){
        manager.context.delete(month)
        save()
    }

    
    func save() {
        months.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            self.manager.save()
            self.getMonths()
            self.getDays()
            self.getTimes()
        }
        
    }
    
}
