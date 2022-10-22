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
    @State private var todaysDate = Date.now
    @State private var showPrevious = false
    
    let days: FetchedResults<DayEntity>
    
    var body: some View {
        NavigationView {
            VStack{
                if days.isEmpty {
                    Spacer()
                    Text("No Times Recorded Yet!")
                        .font(.title3)
                        .bold()
                    Spacer()
                } else {
                    List{
                        Section{
                            ForEach(days, id: \.self){ day in
                                Text(day.wrappedDateInfo)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                ForEach(day.wrappedTimes, id: \.self){ time in
                                        HStack {
                                            Text(time.wrappedDuration) +
                                            Text(time.wrappedDuration == "1" ? " Minute" : " Minutes")
                                            Spacer()
                                            Text("Finished at: \(time.wrappedTimeEnded)")
                                        }
//
//                                    .onDelete(perform: deleteDay)
                                }
                                
                            }
//                            .onDelete(perform: vm.deleteDay)
                        }
                        
                    }
                    
                    
                }
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
                .onAppear {
                    UITableView.appearance().backgroundColor = UIColor.clear
                    UITableViewCell.appearance().backgroundColor = UIColor.clear
                }
            }
            
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
            .navigationTitle("Track Log")
        }
    }
}


extension DateView{
    func deleteDay(index: IndexSet) {
//        moc.delete(days[index])
    }
}
