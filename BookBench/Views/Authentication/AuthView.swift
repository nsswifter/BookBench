//
//  AuthenticationView.swift
//  BookBench
//
//  Created by Mehdi Karami on 4/30/23.
//

import SwiftUI

// MARK: - Auth View

struct AuthView: View {
    @ObservedObject var authViewModel: AuthViewModel
    
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

// MARK: - Auth View Preview

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(authViewModel: AuthViewModel())
    }
}
