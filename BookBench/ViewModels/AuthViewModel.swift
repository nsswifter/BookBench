//
//  AuthenticationViewModel.swift
//  BookBench
//
//  Created by Mehdi Karami on 5/5/23.
//

import Foundation
import Firebase
import FirebaseFirestore

// MARK: - Auth View Model

class AuthViewModel: UIViewController, ObservableObject {
    @Published var currentPage: AuthPage = .logIn
    
    @Published var firstname = ""
    @Published var lastname = ""
    @Published var email = ""
    @Published var password = ""
    @Published var repeatedPassword = ""
    
    @Published var signUpError: String?
    @Published var loginError: String?
    @Published var showResetAlert = false
    @Published var resetEmailAlertMessage = ""
    @Published var resetEmailSent = false

    private let authModel = AuthModel()
    
    /// Logs in the user with the provided email and password.
    /// Uses the Firebase Auth module to perform the login operation.
    /// - Parameter completion: A closure that takes an optional String parameter. It will be called after the login attempt is completed.
    /// If an error occurs during the login process, the error description will be passed as a parameter.
    /// If the login is successful, the parameter will be nil.
    /// - Important: The `email` and `password` properties should be set before calling this function.
    /// - Requires: Firebase/Auth module
    func logIn() {        
        authModel.logIn(email: email, password: password) { result in
            guard result.hasPrefix("<FIRAuthDataResult:") else {
                self.loginError = result
                return
            }
            
            self.currentPage = .signUp
        }
    }
    
    func signUp() {
        authModel.signUp(firstname: firstname, lastname: lastname,
                         email: email,
                         password: password, repeatedPassword: repeatedPassword)  { result in
            guard result.hasPrefix("Success") else {
                self.signUpError = result
                return
            }
            
            self.currentPage = .forgotPassword
        }
    }
    
    func resetPassword() {
        authModel.resetPassword(email: email) { result, error in
            self.resetEmailAlertMessage = result
            self.showResetAlert = true
            
            if !error {
                self.resetEmailSent = true
            }
        }
    }
}

// MARK: - Navigating Between Auth Pages

extension AuthViewModel {
    /// An enumeration of the possible Auth current pages.
    enum AuthPage {
        case logIn
        case signUp
        case forgotPassword
    }
    
    /// Sets the current page to the Login Page.
    func goToLoginPage() {
        currentPage = .logIn
    }
    
    /// Sets the current page to the SignUp Page.
    func goToSignUpPage() {
        currentPage = .signUp
    }
    
    /// Sets the current page to the Forgot Password Page.
    func goToForgotPasswordPage() {
        currentPage = .forgotPassword
    }
}
