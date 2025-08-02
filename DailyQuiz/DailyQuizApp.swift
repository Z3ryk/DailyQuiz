//
//  DailyQuizApp.swift
//  DailyQuiz
//
//  Created by Z3ryk on 01.08.2025.
//

import SwiftUI

@main
struct DailyQuizApp: App {
    @StateObject private var router = AppRouter()

    var body: some Scene {
        WindowGroup {
            NavigationContainer {
                StartQuizView(viewModel: StartQuizViewModel(router: router))
            }
            .environmentObject(router)
        }
    }
}
