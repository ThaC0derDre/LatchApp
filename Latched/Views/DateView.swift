//
//  DateView.swift
//  Latched!
//
//  Created by Andres Gutierrez on 10/19/22.
//

import SwiftUI
import CoreData

// new approach, Change .lasts to ...?
struct DateView: View {
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.dismiss) var dismiss
    let days: FetchedResults<DayEntity>
    
    var body: some View {
        NavigationView {
            VStack{
                if days.isEmpty {
                    emptyList()
                } else {
                    trackedTimes()
                }
                dismissButton()
                    .onAppear {
                        UITableView.appearance().backgroundColor = UIColor.clear
                        UITableViewCell.appearance().backgroundColor = UIColor.clear
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
            .navigationTitle("Track Log")
            .scrollContentBackground(.hidden)
        }
    }
}


extension DateView{
    
    private func emptyList() -> some View {
        VStack{
            Spacer()
            Text("No Times Recorded Yet!")
                .font(.title3)
                .bold()
            Spacer()
        }
    }
    
    private func trackedTimes() -> some View {
        List{
            Section{
                ForEach(days, id: \.self){ day in
                    DisclosureGroup(day.wrappedDateInfo){
                        ForEach(day.wrappedTimes, id: \.self){ time in
                            HStack(alignment: .firstTextBaseline) {
                                Text(time.wrappedDuration) +
                                Text(time.wrappedDuration == "1" ? " Minute" : " Minutes")
                                Spacer()
                                Text("Finished at: ").bold() +
                                Text(time.wrappedTimeEnded)
                            }
                            .font(.subheadline)
                            .fontWeight(.regular)
                            
                        }
                        .onDelete { index in
                            deleteTime(indexs: index, for: day)
                        }
                    }
                    .animation(.default)
                    .font(.title2)
                    .fontWeight(.bold)
                }
                .onDelete(perform: deleteDay)
                
            }
        }
    }
    
    private func dismissButton() -> some View {
        Button {
            dismiss()
        } label: {
            Text("Back to Tracker")
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal)
                .background(Color(hue: 0.328, saturation: 0.796, brightness: 0.408))
                .cornerRadius(30)
        }
    }
    
    func deleteDay(indexs: IndexSet) {
        for index in indexs {
            let day = days[index]
            moc.delete(day)
        }
        try? moc.save()
    }
    
    func deleteTime(indexs: IndexSet, for times: DayEntity) {
        for index in indexs {
            let time = times.wrappedTimes[index]
            moc.delete(time)
        }
        try? moc.save()
    }
}
