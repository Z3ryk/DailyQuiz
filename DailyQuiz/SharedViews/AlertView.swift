//
//  AlertView.swift
//  DailyQuiz
//
//  Created by Z3ryk on 02.08.2025.
//

import SwiftUI

struct AlertView: View {
    // MARK: - Properties

    let title: String
    let subtitle: String
    let buttonTitle: String
    let action: () -> Void

    // MARK: - Views
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()

            VStack(spacing: 12) {
                Text(title)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)

                    Text(subtitle)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                
                Button(action: action) {
                    Text(buttonTitle)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(.purpleMain)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding(.top, 28)
                .padding(.horizontal, 16)
            }
            .padding(.vertical, 32)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 46))
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    AlertView(
        title: "Время вышло!",
        subtitle: "Вы не успели завершить викторину.\nПопробуйте еще раз!",
        buttonTitle: String(localized: "start_over"),
        action: { }
    )
    .background(.purpleMain)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}

