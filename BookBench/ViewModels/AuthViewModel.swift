//
//  AuthenticationViewModel.swift
//  BookBench
//
//  Created by Mehdi Karami on 5/5/23.
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var currentPage: AuthPage = .logIn
    
    @Published var firstname = ""
    @Published var lastname = ""
    @Published var email = ""
    @Published var password = ""
    @Published var repeatedPassword = ""

    func logIn() {
        
    }
    
    func signUp() {
        
    }
    
    func forgotPassword() {
        
    }
}

extension AuthViewModel {
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
