//
//  ContentView.swift
//  BookBench
//
//  Created by Mehdi Karami on 4/30/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var contentViewModel: ContentViewModel

    var body: some View {
        ZStack {
            Group {
                switch contentViewModel.currentPage {
                case .launchScreen:
                    LaunchScreenView()
                case .auth:
                    AuthView()
                case .main:
                    MainView()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline:.now() + 3) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        contentViewModel.currentPage = .auth
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(contentViewModel: ContentViewModel())
    }
}
