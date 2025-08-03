//
//  QuizViewModel.swift
//  DailyQuiz
//
//  Created by Z3ryk on 02.08.2025.
//

import SwiftUI

final class QuizViewModel: ObservableObject {
    // MARK: - State
    
    struct State {
        var currentQuestionIndex = 0
        var selectedAnswer: String?
        var score = 0
        var shuffledAnswers: [String] = []
        var timeRemaining = Constants.totalTimeInSeconds
        var showTimerExpiredOverlay = false

        static let initial: Self = .init()
    }
    
    @Published var state: State = .initial

    // MARK: - Properties
    
    private let quizInfo: QuizInfo
    private var timer: Timer?
    private let router: AppRouter
    private let historyManager: QuizHistoryManager

    var currentQuestion: QuizInfo.Result {
        quizInfo.results[state.currentQuestionIndex]
    }
    
    var isLastQuestion: Bool {
        state.currentQuestionIndex == quizInfo.results.count - 1
    }
    
    var questionNumberText: String {
        "Вопрос \(state.currentQuestionIndex + 1) из \(quizInfo.results.count)"
    }

    var totalTimeInMinutes: String {
        let totalSeconds = Constants.totalTimeInSeconds
        let minutes = totalSeconds / Constants.oneMinuteInSeconds
        let seconds = totalSeconds % Constants.oneMinuteInSeconds
        return String(format: "%d:%02d", minutes, seconds)
    }

    var elapsedTimeText: String {
        let elapsedSeconds = Constants.totalTimeInSeconds - state.timeRemaining
        let minutes = elapsedSeconds / Constants.oneMinuteInSeconds
        let seconds = elapsedSeconds % Constants.oneMinuteInSeconds
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var progressValue: Double {
        let elapsedTime = Double(Constants.totalTimeInSeconds - state.timeRemaining)
        return elapsedTime / Double(Constants.totalTimeInSeconds)
    }
    
    // MARK: - Lifecycle

    init(
        quizInfo: QuizInfo,
        router: AppRouter,
        historyManager: QuizHistoryManager = .shared
    ) {
        self.quizInfo = quizInfo
        self.router = router
        self.historyManager = historyManager

        updateShuffledAnswers()
        startTimer()
    }
    
    deinit {
        stopTimer()
    }
    
    // MARK: - Internal Methods

    func setSelectedAnswer(to answer: String) {
        state.selectedAnswer = answer
    }

    func checkAnswer() {
        if state.selectedAnswer == currentQuestion.correctAnswer {
            state.score += 1
        }
    }

    func nextQuestion() {
        if isLastQuestion {
            historyManager.saveQuizHistoryItem(
                QuizHistoryItem(
                    id: UUID(),
                    title: "Quiz \(historyManager.entities.count + 1)",
                    score: state.score,
                    totalQuestions: quizInfo.results.count,
                    completedAt: Date()
                )
            )
            router.navigateToResults(score: state.score, totalQuestions: quizInfo.results.count)
            stopTimer()
        } else {
            state.currentQuestionIndex += 1
            state.selectedAnswer = nil
            updateShuffledAnswers()
        }
    }

    func navigateToStart() {
        router.popToRoot()
    }

    // MARK: - Private Methods
    
    private func updateShuffledAnswers() {
        var answers = currentQuestion.incorrectAnswers
        answers.append(currentQuestion.correctAnswer)
        state.shuffledAnswers = answers.shuffled()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true
        ) { [weak self] _ in
            self?.updateTimer()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateTimer() {
        guard state.timeRemaining > 0 else {
            state.showTimerExpiredOverlay = true
            stopTimer()
            return
        }
        
        state.timeRemaining -= 1
    }
}

private extension QuizViewModel {
    enum Constants {
        static let totalTimeInSeconds: Int = 300
        static let oneMinuteInSeconds: Int = 60
    }
}
