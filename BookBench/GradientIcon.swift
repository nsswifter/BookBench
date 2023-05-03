//
//  GradientIcon.swift
//  BookBench
//
//  Created by Mehdi Karami on 4/30/23.
//

import SwiftUI

struct GradientIcon: View {
    @Environment(\.colorScheme) private var colorScheme
    var systemName: String
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .indigo, .purple]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .cornerRadius(15)
            
            Image(systemName: systemName)
                .font(.title2)
                .foregroundColor(colorScheme == .dark ? .black : .white)
        }
        .frame(width: 40, height: 40)
    }
}

struct GradientIcon_Previews: PreviewProvider {
    static var previews: some View {
        GradientIcon(systemName: "tree")
    }
}
