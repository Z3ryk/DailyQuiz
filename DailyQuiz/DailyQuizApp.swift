//
//  DailyQuizApp.swift
//  DailyQuiz
//
//  Created by Z3ryk on 01.08.2025.
//

import SwiftUI

@main
struct DailyQuizApp: App {
    var body: some Scene {
        WindowGroup {
            StartQuizView(viewModel: StartQuizViewModel())
        }
    }
}
