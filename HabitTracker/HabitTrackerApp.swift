//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Стас Жингель on 03.08.2021.
//

import SwiftUI

@main
struct HabitTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
