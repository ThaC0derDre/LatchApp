//
//  LatchedApp.swift
//  Latched
//
//  Created by Andres Gutierrez on 3/19/22.
//

import SwiftUI

@main
struct LatchedApp: App {
    @StateObject private var manager = CoreDataManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, manager.container.viewContext)
        }
    }
}
