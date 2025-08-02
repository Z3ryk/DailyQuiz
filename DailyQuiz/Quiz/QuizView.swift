//
//  QuizView.swift
//  DailyQuiz
//
//  Created by Z3ryk on 02.08.2025.
//

import SwiftUI

struct QuizView: View {
    // MARK: - Properties

    let quizInfo: QuizInfo
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: String?
    @State private var showResult = false
    @State private var score = 0
    @State private var shuffledAnswers: [String] = []
    @Environment(\.dismiss) private var dismiss

    // MARK: - Computed Properties

    private var currentQuestion: QuizInfo.Result {
        quizInfo.results[currentQuestionIndex]
    }

    private var isLastQuestion: Bool {
        currentQuestionIndex == quizInfo.results.count - 1
    }

    // MARK: - Views

    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 24) {
                // Номер вопроса
                Text("Вопрос \(currentQuestionIndex + 1) из \(quizInfo.results.count)")
                    .foregroundStyle(.purpleLight)
                    .font(.system(size: 16, weight: .semibold))

                // Вопрос
                Text(currentQuestion.question)
                    .foregroundStyle(.black)
                    .font(.system(size: 18, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)

                // Ответы
                VStack(spacing: 12) {
                    ForEach(shuffledAnswers, id: \.self) { answer in
                        Button(action: {
                            selectedAnswer = answer
                        }) {
                            HStack(spacing: 16) {
                                ZStack {
                                    Circle()
                                        .fill(selectedAnswer == answer ? Color.purpleDark : Color.white)
                                        .frame(width: 24, height: 24)
                                        .overlay(
                                            Circle()
                                                .stroke(Color.black, lineWidth: 1)
                                        )

                                    if selectedAnswer == answer {
                                        Image(systemName: "checkmark")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 12, weight: .bold))
                                    }
                                }

                                Text(answer)
                                    .foregroundStyle(.black)
                                    .font(.system(size: 16, weight: .regular))
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(selectedAnswer == answer ? Color.white : Color.gray.opacity(0.3))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(selectedAnswer == answer ? Color.purpleDark : Color.clear, lineWidth: 1)
                                    )
                            )
                        }
                        .disabled(selectedAnswer != nil)
                    }
                }
                .padding(.horizontal, 16)

                // Кнопка ДАЛЕЕ
                Button(action: {
                    if selectedAnswer == currentQuestion.correctAnswer {
                        score += 1
                    }

                    if isLastQuestion {
                        showResult = true
                    } else {
                        withAnimation(.easeInOut) {
                            nextQuestion()}
                    }
                }) {
                    Text("ДАЛЕЕ")
                        .foregroundStyle(selectedAnswer != nil ? .white : .gray)
                        .font(.system(size: 16, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(selectedAnswer != nil ? Color.purpleMain : Color.gray.opacity(0.3))
                        .cornerRadius(12)
                }
                .disabled(selectedAnswer == nil)
                .padding(.horizontal, 16)
                .padding(.top, 43)
            }
            .padding(.vertical, 32)
            .padding(.horizontal, 16)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 46))
            .padding(.horizontal, 26)
            .padding(.top, 40)

            Text("Вернуться к предыдущим вопросам нельзя")
                .font(.system(size: 10, weight: .regular))
                .foregroundStyle(.white)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.purpleMain)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.top, 43)
                }
            }

            ToolbarItem(placement: .principal) {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                    .padding(.top, 35)
            }
        }
        .alert("Результат", isPresented: $showResult) {
            Button("Начать заново") {
                resetQuiz()
            }
        } message: {
            Text("Ваш результат: \(score) из \(quizInfo.results.count)")
        }
        .onAppear {
            updateShuffledAnswers()
        }
    }

    // MARK: - Private

    private func nextQuestion() {
        currentQuestionIndex += 1
        selectedAnswer = nil
        updateShuffledAnswers()
    }

    private func resetQuiz() {
        currentQuestionIndex = 0
        selectedAnswer = nil
        score = 0
        showResult = false
        updateShuffledAnswers()
    }

    private func updateShuffledAnswers() {
        var answers = currentQuestion.incorrectAnswers
        answers.append(currentQuestion.correctAnswer)
        shuffledAnswers = answers.shuffled()
    }
}

#Preview {
    NavigationStack {
        QuizView(quizInfo: QuizInfo(
            responseCode: 0,
            results: [
                QuizInfo.Result(
                    type: "multiple",
                    difficulty: "easy",
                    category: "General Knowledge",
                    question: "What is the capital of France?",
                    correctAnswer: "Paris",
                    incorrectAnswers: ["London", "Berlin", "Madrid"]
                )
            ]
        ))
    }
}
