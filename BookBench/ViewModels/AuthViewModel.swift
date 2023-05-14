//
//  AuthenticationViewModel.swift
//  BookBench
//
//  Created by Mehdi Karami on 5/5/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import Security

// MARK: - Auth View Model

class AuthViewModel: ObservableObject {
    @Published var currentPage: AuthPage = .logIn
    
    @Published var firstname = ""
    @Published var lastname = ""
    @Published var email = ""
    @Published var password = ""
    @Published var repeatedPassword = ""
    
    func logIn() {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            guard let error else {
                print("success")
                return
            }
            
            print(error.localizedDescription)
        }
    }
    
    func signUp() {
        if password == repeatedPassword {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                guard let user = authResult?.user, error == nil else {
                    print("Error creating user: \(error!.localizedDescription)")
                    return
                }
                
                saveAdditionalUserInfo(for: user)
            }
        } else {
            print("passwords is not matchs")
        }
        
        func saveAdditionalUserInfo(for user: User) {
            let dataBase = Firestore.firestore()
            
            dataBase.collection("users").document(user.uid).setData([
                "firstname": firstname,
                "lastname": lastname,
                "email": email
            ]) { error in
                if let error = error {
                    print("Error saving user info: \(error.localizedDescription)")
                } else {
                    print("User info saved successfully!")
                }
            }
        }
    }
    
    func forgotPassword() {
        func sendPasswordResetEmail() {
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in

            }
        }
    }
    
    func autoLogIn(with mode: inout Bool) {
        var localMode = mode
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                localMode.toggle()
            }
        }
        mode = localMode
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
