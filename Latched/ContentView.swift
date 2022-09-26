//
//  ContentView.swift
//  Latched
//
//  Created by Andres Gutierrez on 3/19/22.
//

import SwiftUI
import RealmSwift



struct ContentView: View {
    
    @StateObject var realmManager       = RealmManager()
    
    
    @State private var startTime        = ""
    @State private var endTime          = ""
    @State private var timeDifference   = ""
    @State private var minsPassed       = ""
    
    
    @State private var showTimeView     = false
    @State private var timeCounting     = false
    @State private var timerStopped     = false
    @State private var tFormatter       = TimeFormatter()
    @State private var theDate          :Date?
    @State private var timer = Timer.publish(every: 0, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        NavigationView{
            VStack {
                Form{
                    if !timeCounting { startTimerButton }
                    else { beginCounter }
                    
                    if timerStopped { timePassed }
                    
                    viewPreviousTimes
                        .sheet(isPresented: $showTimeView) {
                            TrackTimeView()
                                .environmentObject(realmManager)
                        }
                }
                .preferredColorScheme(.light)
                
                //MARK: - Button
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
    
    
    private var timePassed: Text {
        Text(timeDifference == "0" ? "Zero minutes passed that time." : "Total: \(timeDifference) minutes")
    }
    
    
    private func buttonAction() {
        timeCounting    = false
        timerStopped    = true
        endTime         = tFormatter.getCurrentTime()
        theDate         = Date.now
        timeDifference  = tFormatter.findDateDiff(time1Str: startTime, time2Str: endTime)
        
        if timeDifference != "" {
            realmManager.addTime(lastFed: endTime, duration: timeDifference, currentDate: theDate)
        }
    }
}
