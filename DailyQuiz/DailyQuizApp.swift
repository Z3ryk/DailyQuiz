//
//  DailyQuizApp.swift
//  DailyQuiz
//
//  Created by Z3ryk on 01.08.2025.
//

import SwiftUI

@main
struct DailyQuizApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
