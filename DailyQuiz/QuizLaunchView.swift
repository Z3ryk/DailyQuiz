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
        VStack{
            
        }
        VStack{
            VStack{
                Text("Добро пожаловать в DailyQuiz!")
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing], 24)
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                    .font(.system(size: 28, weight: .bold))

                Button(action: action) {
                    Text("НАЧАТЬ ВИКТОРИНУ")
                        .padding([.leading, .trailing], 51)
                        .padding([.top, .bottom], 16)
                        .background(.purpleMain)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .font(.system(size: 16, weight: .black))
                }
            }
            .padding(16)
            .padding(.bottom, 16)
            .background(.white)
            .cornerRadius(46)
        }
    }

    // MARK: - Lifecycle

    init(action: @escaping () -> Void) {
        self.action = action
    }
}

#Preview {
    QuizLaunchView { }
}
