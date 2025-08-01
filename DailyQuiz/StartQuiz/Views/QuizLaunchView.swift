//
//  QuizLaunchView.swift
//  DailyQuiz
//
//  Created by Z3ryk on 01.08.2025.
//

import SwiftUI

struct QuizLaunchView: View {
    // MARK: - Properties

    private let action: () -> Void

    // MARK: - Views

    var body: some View {
        VStack(spacing: 40) {
            Text("Добро пожаловать в DailyQuiz!")
                .multilineTextAlignment(.center)
                .font(.system(size: 28, weight: .bold))

            Button(action: action) {
                Text("НАЧАТЬ ВИКТОРИНУ")
                    .padding(.vertical, 16)
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .black))
            }
            .frame(maxWidth: .infinity)
            .background(.purpleMain)
            .cornerRadius(16)
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 32)
        .padding(.horizontal, 24)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 46))
    }

    // MARK: - Lifecycle

    init(action: @escaping () -> Void) {
        self.action = action
    }
}

#Preview {
    QuizLaunchView { }
}
