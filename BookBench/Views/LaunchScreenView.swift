//
//  LaunchScreenView.swift
//  BookBench
//
//  Created by Mehdi Karami on 4/30/23.
//

import SwiftUI

// MARK: - Launch Screen View

struct LaunchScreenView: View {
    var body: some View {
        LottieView(name: "BookBenchAnimation")
    }
}

// MARK: - Launch Screen View Preview

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
