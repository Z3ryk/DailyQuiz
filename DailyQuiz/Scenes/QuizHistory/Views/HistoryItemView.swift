//
//  QuizHistoryView.swift
//  DailyQuiz
//
//  Created by Z3ryk on 03.08.2025.
//

import SwiftUI

struct HistoryItemView: View {
    let title: String
    let score: Int
    let date: String
    let time: String

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text(title)
                    .font(.system(size: 24, weight: .bold))

                Spacer()

                HStack(spacing: 8) {
                    ForEach(0..<5, id: \.self) { index in
                        Image(index < score ? .customStarFill : .customStar)
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                }
            }

            HStack(alignment: .center) {
                Text(date)
                    .font(.system(size: 12, weight: .regular))

                Spacer()

                Text(time)
                    .font(.system(size: 12, weight: .regular))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 40))
    }
}

#Preview {
    VStack {
        HistoryItemView(
            title: "Quiz 1",
            score: 3,
            date: "3 августа",
            time: "15:00"
        )
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.purpleMain)
}
