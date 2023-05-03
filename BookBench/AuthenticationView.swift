//
//  AuthenticationView.swift
//  BookBench
//
//  Created by Mehdi Karami on 4/30/23.
//

import SwiftUI

struct AuthenticationView: View {
    @Environment(\.colorScheme) private var colorScheme
    @StateObject var authFlowState = AuthFlowState()
    
    @State var start = UnitPoint(x: -0.5, y: -2)
    @State var end = UnitPoint(x: 4, y: 0)
    
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: colorScheme == .dark ?
                                              [.indigo, .black, .purple,
                                                .black, .indigo, .black]
                                              :
                                                [.indigo, .white, .purple,
                                                 .white, .indigo, .white]
                                                ), startPoint: start, endPoint: end)
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
            .ignoresSafeArea()
                  
            Group {
                switch authFlowState.currentPage {
                case .logIn:
                    LogInView()
                case .signUp:
                    SignUpView()
                case .forgotPassword:
                    ForgotPasswordView()
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}


struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
