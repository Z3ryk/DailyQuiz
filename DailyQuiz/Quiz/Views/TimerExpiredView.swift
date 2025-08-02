//
//  TimerExpiredView.swift
//  DailyQuiz
//
//  Created by Z3ryk on 02.08.2025.
//

import SwiftUI

struct TimerExpiredView: View {
    // MARK: - Properties
    
    let onRestart: () -> Void
    
    // MARK: - Views
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Text("Время вышло!")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)

                VStack(spacing: 8) {
                    Text("Вы не успели завершить викторину.")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                    
                    Text("Попробуйте еще раз!")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                }
                
                Button(action: onRestart) {
                    Text("НАЧАТЬ ЗАНОВО")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(.purpleMain)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            .padding(32)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 46))
            .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 10)
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    TimerExpiredView { }
}

