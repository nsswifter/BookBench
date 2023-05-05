//
//  AuthFlowState.swift
//  BookBench
//
//  Created by Mehdi Karami on 4/30/23.
//

import Foundation

class AuthFlowState: ObservableObject {
    @Published var currentPage: AuthPage = .logIn
    
    enum AuthPage {
        case logIn
        case signUp
        case forgotPassword
    }
    
    func goToLoginPage() {
        currentPage = .logIn
    }
    
    func goToSignUpPage() {
        currentPage = .signUp
    }
    
    func goToForgotPasswordPage() {
        currentPage = .forgotPassword
    }
}
