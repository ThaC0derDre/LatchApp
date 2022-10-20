//
//  TimeTrackerView.swift
//  Latched
//
//  Created by Andres Gutierrez on 3/27/22.
//

import SwiftUI
import RealmSwift

struct TrackTimeView: View {
    @ObservedResults(Time.self) var times
    @EnvironmentObject var  realmManager: RealmManager
    @Environment(\.dismiss) var dismiss
    @State private var lastFedAt    = ""
    @State private var durationFed  = ""
    @State private var currentDate  = Date.now
    @State private var nextDay      = ""
    @State private var newDay       = false
    
    
    var body: some View {
        VStack {
            textLabel
            
            List {
                ForEach(realmManager.times, id: \.id) { time in
                    if !time.isInvalidated {
                        TimeRow(finishedTime: time.lastFed, totalDuration: time.duration, currentDate: time.currentDate.displayDate)
                            
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    realmManager.deleteTime(id: time.id)
                                }label: {
                                     Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                }
//                .onDelete(perform: $times.remove)
            }
            .onAppear {
                UITableView.appearance().backgroundColor = UIColor.clear
                UITableViewCell.appearance().backgroundColor = UIColor.clear
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
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
    }
}

struct TrackTimeView_Previews: PreviewProvider {
    static var previews: some View {
        TrackTimeView()
            .environmentObject(RealmManager())
    }
}


extension TrackTimeView {
    private var textLabel : some View {
        Text("Time Tracker")
            .font(.title3).bold()
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
