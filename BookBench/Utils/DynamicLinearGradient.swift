//
//  DynamicLinearGradient.swift
//  BookBench
//
//  Created by Mehdi Karami on 5/5/23.
//

import SwiftUI

// MARK: - Dynamic Linear Gradient View

/// A SwiftUI view that renders a linear gradient with changing colors and animation.
struct DynamicLinearGradient: View {
    
    // The environment color scheme, used to determine the gradient colors to use.
    @Environment(\.colorScheme) private var colorScheme

    // The starting point of the gradient.
    @State var start = UnitPoint(x: -0.5, y: -2)
    // The ending point of the gradient.
    @State var end = UnitPoint(x: 4, y: 0)
    
    // A timer that triggers a change in the gradient's start and end points.
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    var lightModeColors = [Color.indigo, .white, .purple, .white, .indigo, .white]
    var darkModeColors = [Color.indigo, .black, .purple, .black, .indigo, .black]
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: colorScheme == .dark ?
                                          darkModeColors : lightModeColors),
                       startPoint: start, endPoint: end)
        .animation(Animation.easeInOut(duration: 30)
            .repeatForever(autoreverses: true).speed(2), value: start)
        .animation(Animation.easeInOut(duration: 30)
            .repeatForever(autoreverses: true).speed(2), value: end)
        .onReceive(timer, perform: { _ in
            self.start = UnitPoint(x: 4, y: 0)
            self.end = UnitPoint(x: 0, y: 2)
            self.start = UnitPoint(x: -4, y: 20)
            self.start = UnitPoint(x: 4, y: 0)
        })
    }
}

// MARK: - Dynamic Linear Gradient View Preview

struct DynamicLinearGradient_Previews: PreviewProvider {
    static var previews: some View {
        DynamicLinearGradient()
    }
}
