//
//  NavigationContainer.swift
//  DailyQuiz
//
//  Created by Z3ryk on 02.08.2025.
//

import SwiftUI

struct NavigationContainer<Content: View>: View {
    @EnvironmentObject private var router: AppRouter

    let content: () -> Content

    var body: some View {
        NavigationStack(path: $router.path) {
            content()
                .navigationDestination(for: Screen.self) { screen in
                    screen.destinationView()
                }
        }
    }
}
