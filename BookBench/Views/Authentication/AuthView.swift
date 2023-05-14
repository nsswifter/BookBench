//
//  AuthenticationView.swift
//  BookBench
//
//  Created by Mehdi Karami on 4/30/23.
//

import SwiftUI

struct AuthView: View {
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some View {
        ZStack {
            DynamicLinearGradient().ignoresSafeArea()
                  
            Group {
                switch authViewModel.currentPage {
                case .logIn:
                    LogInView(authViewModel: authViewModel)
                case .signUp:
                    SignUpView(authViewModel: authViewModel)
                case .forgotPassword:
                    ForgotPasswordView(authViewModel: authViewModel)
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
        AuthView()
    }
}
