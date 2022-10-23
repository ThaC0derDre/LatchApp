//
//  ContentView.swift
//  Latched
//
//  Created by Andres Gutierrez on 3/19/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    @State private var startTime        = ""
    @State private var endTime          = ""
    @State private var timeDifference   = ""
    @State private var minsPassed       = ""
    
    @State private var showTimeView     = false
    @State private var timeCounting     = false
    @State private var timerStopped     = false
    @State private var tFormatter       = TimeFormatter()
    @State private var timer = Timer.publish(every: 0, on: .main, in: .common).autoconnect()
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.date, order: .reverse)
    ]) var days: FetchedResults<DayEntity>
    
    var body: some View {
        NavigationView{
            VStack {
                Form{
                    if !timeCounting { startTimerButton }
                    else { beginCounter }
                    
                    if timerStopped { timePassedLabel }
                    
                    viewPreviousTimes
                        .sheet(isPresented: $showTimeView) {
                            DateView(days: days)
                        }
                }
                .preferredColorScheme(.light)
                
                trackingButton()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
            .navigationTitle("LATCHED")
            .navigationBarTitleDisplayMode(.inline)
            .animation(.default, value: timeCounting)
            .scrollContentBackground(.hidden)
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension ContentView {
    private var startTimerButton: some View {
        Button("Start Timer"){
            timerStopped    = false
            startTime       = tFormatter.getCurrentTime()
            guard !timeCounting else { return }
            timeCounting.toggle()
            self.timer = Timer.publish(every: 0, on: .main, in: .common).autoconnect()
        }
    }
    
    
    private var beginCounter: some View {
        Section {
            Text("Latched at \(startTime)")
            Text(minsPassed == "0" ? "Counting Minutes..." : "Minutes passed: \(minsPassed)")
        }
    }
    
    
    private var viewPreviousTimes : some View {
        Section {
            Button("View Previous Times") { }
                .onTapGesture {
                    showTimeView.toggle()
                }
        }
    }
    
    
    private var timePassedLabel: Text {
        Text(timeDifference == "0" ? "Zero minutes passed that time." : "Total: \(timeDifference) minutes")
    }
    
    
    private func trackingButton() -> some View {
        ZStack(alignment:.bottom) {
            if timeCounting{
                AnimatedButton()
                    .padding(.bottom, 20)
                Button("END") { buttonAction() }
                    .font(.title2.bold())
                    .padding(80)
                    .foregroundColor(.white)
                    .onReceive(timer) { _ in
                        if !timeCounting {
                            self.timer.upstream.connect().cancel()
                            return
                        }else {
                            endTime = tFormatter.getCurrentTime()
                            minsPassed = tFormatter.findDateDiff(time1Str: startTime, time2Str: endTime)
                        }
                    }
            }
        }
    }
    
    
    private func buttonAction() {
        timeCounting    = false
        timerStopped    = true
        endTime         = tFormatter.getCurrentTime()
        timeDifference  = tFormatter.findDateDiff(time1Str: startTime, time2Str: endTime)
        
        if timeDifference != "" {
            addRecord()
        }
    }
    
    
    private func addRecord(){
        let newTime = TimeEntity(context: moc)
        newTime.timeEnded = endTime
        newTime.duration = timeDifference
        newTime.dateAdded = Date.now
        
        newTime.day = DayEntity(context: moc)
        newTime.day?.date = Date.now
        newTime.day?.dateInfo = Date.now.displayDate
        
        try? moc.save()
    }
    
}
