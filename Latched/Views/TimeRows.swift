//
//  TimeRows.swift
//  Latched
//
//  Created by Andres Gutierrez on 3/27/22.
//

import SwiftUI

struct TimeRow: View {
    var finishedTime: String
    var totalDuration: String
    var currentDate: String?
    
    
    var body: some View {
        if let currentDate = currentDate {
        VStack{
            Text(currentDate)
                .fontWeight(.heavy)
        }
        .listRowSeparator(.hidden)
        .font(.headline)
        }
        HStack(spacing: 30) {
            Text(" Finished at \(finishedTime)")
            Text("\(totalDuration) minutes total")
        }
        .listRowSeparator(.visible)
    }
}

struct TimeRow_Previews: PreviewProvider {
    static var previews: some View {
        TimeRow(finishedTime: "12:00p", totalDuration: "30", currentDate: nil)
    }
}
