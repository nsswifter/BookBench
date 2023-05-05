//
//  DynamicLinearGradient.swift
//  BookBench
//
//  Created by Mehdi Karami on 5/5/23.
//

import SwiftUI

struct DynamicLinearGradient: View {
    @Environment(\.colorScheme) private var colorScheme

    @State var start = UnitPoint(x: -0.5, y: -2)
    @State var end = UnitPoint(x: 4, y: 0)
    
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

struct DynamicLinearGradient_Previews: PreviewProvider {
    static var previews: some View {
        DynamicLinearGradient()
    }
}
