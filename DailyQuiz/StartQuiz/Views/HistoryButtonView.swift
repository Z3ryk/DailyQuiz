//
//  HistoryButtonView.swift
//  DailyQuiz
//
//  Created by Z3ryk on 01.08.2025.
//

import SwiftUI

struct HistoryButtonView: View {
    // MARK: - Properties

    private let action: () -> Void

    // MARK: - Views

    var body: some View {
        Button(
            action: action,
            label: {
                HStack(spacing: 12) {
                    Text("История")
                        .font(.system(size: 12, weight: .semibold))

                    Image(.historyIcon)
                        .frame(width: 16, height: 16)
                }
                .padding(12)
            }
        )
        .foregroundStyle(.purpleMain)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    // MARK: - Lifecycle

    init(action: @escaping () -> Void) {
        self.action = action
    }
}

#Preview {
    HistoryButtonView { }
}
