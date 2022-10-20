//
//  WouldBeAppp.swift
//  Latched!
//
//  Created by Andres Gutierrez on 10/19/22.
//

import SwiftUI

struct WouldBeAppp: View {
    @StateObject var vm = CoreDataVM()
    private var today   = Date.now
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20){
                Button("Add") {
                    vm.deleteMonth(vm.months.last!)
                }
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue.cornerRadius(10))
                Text("By Months..")
                ForEach(vm.months, id: \.self) {
                    MonthView(entity: $0)
                }
            }
            .padding()
            .navigationTitle("Date Tracker")
        }
    }
}

struct WouldBeAppp_Previews: PreviewProvider {
    static var previews: some View {
        WouldBeAppp()
    }
}

struct MonthView: View {
    let entity : MonthEntity
    
    var body: some View {
        VStack {
            
            Text(entity.name ?? "What's the Month?")
                .bold().font(.largeTitle)
            if let days = entity.days?.allObjects as? [DayEntity] {
                ForEach(days, id: \.self) { day in
                    HStack{
                        Text("Day: ").bold()
                        Text(day.name ?? "What's today?")
                    }
                }
            }
            if let times = entity.times?.allObjects as? [TimeEntity] {
                ForEach(times, id: \.self) { time in
                    HStack{
                        Text("Time Ended: ").bold()
                        Text(time.timeEnded ?? "Time ended?")
                    }
                    HStack{
                        Text("Duration: ").bold()
                        Text(time.duration ?? "How long?")
                    }
                }
            }
            
        }
    }
}
