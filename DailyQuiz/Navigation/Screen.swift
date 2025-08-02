//
//  Screen.swift
//  DailyQuiz
//
//  Created by Z3ryk on 02.08.2025.
//

import SwiftUI

enum Screen: Hashable {
    case quiz(quizInfo: QuizInfo)

    @ViewBuilder
    @MainActor
    func destinationView() -> some View {
        switch self {
        case .quiz(let quizInfo):
            QuizView(quizInfo: quizInfo)
        }
    }
}
