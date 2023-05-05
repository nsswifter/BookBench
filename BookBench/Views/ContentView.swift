//
//  ContentView.swift
//  BookBench
//
//  Created by Mehdi Karami on 4/30/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isLaunchScreenShown = false
    
    var body: some View {
        ZStack {
            Group{
                if !isLaunchScreenShown {
                    LaunchScreenView()
                }
                else {
                    AuthenticationView()
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
        ContentView()
    }
}
