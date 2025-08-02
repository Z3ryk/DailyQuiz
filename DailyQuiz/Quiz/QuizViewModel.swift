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
        var showResult = false
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
    
    // MARK: - Initialization
    
    init(quizInfo: QuizInfo) {
        self.quizInfo = quizInfo
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
            state.showResult = true
            stopTimer()
        } else {
            state.currentQuestionIndex += 1
            state.selectedAnswer = nil
            updateShuffledAnswers()
        }
    }
    
    func resetQuiz() {
        state = .initial
        updateShuffledAnswers()
        startTimer()
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
            state.showResult = true
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
