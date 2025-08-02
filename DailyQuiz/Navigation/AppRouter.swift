//
//  AppRouter.swift
//  DailyQuiz
//
//  Created by Z3ryk on 02.08.2025.
//

import SwiftUI

final class AppRouter: ObservableObject {
    @Published var path: [Screen] = []

    func navigateToQuiz(with quizInfo: QuizInfo) {
        path.append(.quiz(quizInfo: quizInfo))
    }
    
    func navigateToResults(score: Int, totalQuestions: Int) {
        path.append(.results(score: score, totalQuestions: totalQuestions))
    }
}
