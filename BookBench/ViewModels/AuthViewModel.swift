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
    @Published var currentPage: AuthPage? = .logIn
    @Published var isLoggedIn = false
    
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
    
    // It is used for authentication-related operations.
    private let authModel = AuthModel()
    
    /// Initiates LogIn operation.
    func logIn() {
        authModel.logIn(email: email, password: password) { result in
            guard result.hasPrefix("<FIRAuthDataResult:") else {
                self.loginError = result
                return
            }
            
            self.currentPage = nil
            self.isLoggedIn = true
        }
    }
    
    /// Initiates SignUp operation.
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
    
    /// Initiates Reset Password operation.
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
}
