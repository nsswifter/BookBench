//
//  ContentView.swift
//  BookBench
//
//  Created by Mehdi Karami on 4/30/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var authViewModel: AuthViewModel

    @State private var isLaunchScreenShown = false

    var body: some View {
        ZStack {
            Group{
                if !isLaunchScreenShown {
                    LaunchScreenView()
                }
                else {
                    AuthView(authViewModel: authViewModel)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline:.now() + 3) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        self.isLaunchScreenShown = true
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(authViewModel: AuthViewModel())
    }
}
