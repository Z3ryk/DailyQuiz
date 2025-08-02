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
        var timeRemaining: TimeInterval = Constants.totalTimeInSeconds
        var isTimerRunning = false

        static let initial: Self = .init()
    }
    
    @Published var state: State = .initial

    // MARK: - Properties
    
    private let quizInfo: QuizInfo
    private var timer: Timer?
    private let router: AppRouter

    var currentQuestion: QuizInfo.Result {
        quizInfo.results[state.currentQuestionIndex]
    }
    
    var isLastQuestion: Bool {
        state.currentQuestionIndex == quizInfo.results.count - 1
    }
    
    var questionNumberText: String {
        "Вопрос \(state.currentQuestionIndex + 1) из \(quizInfo.results.count)"
    }
    
    var resultText: String {
        "Ваш результат: \(state.score) из \(quizInfo.results.count)"
    }
    
    var currentTimeText: String {
        let minutes = Int(state.timeRemaining) / Constants.oneMinuteInSeconds
        let seconds = Int(state.timeRemaining) % Constants.oneMinuteInSeconds
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var elapsedTimeText: String {
        let elapsedSeconds = Constants.totalTimeInSeconds - state.timeRemaining
        let minutes = Int(elapsedSeconds) / Constants.oneMinuteInSeconds
        let seconds = Int(elapsedSeconds) % Constants.oneMinuteInSeconds
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var progressValue: Double {
        (Constants.totalTimeInSeconds - state.timeRemaining) / Constants.totalTimeInSeconds
    }
    
    // MARK: - Lifecycle

    init(quizInfo: QuizInfo, router: AppRouter) {
        self.quizInfo = quizInfo
        self.router = router
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
        state.isTimerRunning = true
        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true
        ) { [weak self] _ in
            self?.updateTimer()
        }
    }
    
    private func stopTimer() {
        state.isTimerRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    private func updateTimer() {
        guard state.timeRemaining > 0 else {
            state.showTimerExpired = true
            stopTimer()
            return
        }
        
        state.timeRemaining -= 1
    }
}

private extension QuizViewModel {
    enum Constants {
        static let totalTimeInSeconds: CGFloat = 300.0
        static let oneMinuteInSeconds: Int = 60
    }
}
