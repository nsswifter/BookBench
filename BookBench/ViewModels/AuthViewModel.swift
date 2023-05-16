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
    
    /// Logs in the user with the provided email and password.
    /// Uses the Firebase Auth module to perform the login operation.
    /// - Parameter completion: A closure that takes an optional String parameter. It will be called after the login attempt is completed.
    /// If an error occurs during the login process, the error description will be passed as a parameter.
    /// If the login is successful, the parameter will be nil.
    /// - Important: The `email` and `password` properties should be set before calling this function.
    /// - Requires: Firebase/Auth module
    func logIn(completion: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error {
                completion(error.localizedDescription)
            } else {
                
            }
        }
    }
    
    /// Signs up a new user with the provided information.
    /// Uses the Firebase Auth and Firestore modules to perform the signup operation and save additional user info.
    /// - Parameter completion: A closure that takes an optional String parameter. It will be called after the signup attempt is completed.
    /// If an error occurs during the signup process, the error description will be passed as a parameter.
    /// If the signup is successful, the parameter will be nil.
    /// - Important: The `firstname`, `lastname`, `password`, `repeatedPassword`, and `email` properties should be set before calling this function.
    /// - Requires: Firebase/Auth and Firebase/Firestore modules
    func signUp(completion: @escaping (String?) -> Void) {
        guard !firstname.isEmpty else {
            completion("Enter your firstname.")
            return
        }
        
        guard !lastname.isEmpty else {
            completion("Enter your lastname.")
            return
        }
        
        guard password == repeatedPassword else {
            completion("Passwords don't match.")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error {
                completion(error.localizedDescription)
            } else {
                guard let user = authResult?.user else {
                    completion("Error creating user.")
                    return
                }
                self.saveAdditionalUserInfo(for: user, completion: completion)
            }
        }
    }
    
    /// Saves additional user information to the Firestore database.
    /// - Parameters:
    ///   - user: The `User` object representing the user whose information needs to be saved.
    ///   - completion: A closure that takes an optional String parameter. It will be called after the saving process is completed.
    ///                 If an error occurs during the saving process, the error description will be passed as a parameter.
    ///                 If the saving is successful, the parameter will be "Success".
    /// - Important: The `firstname`, `lastname`, and `email` properties should be set before calling this function.
    /// - Requires: Firebase/Firestore module
    func saveAdditionalUserInfo(for user: User, completion: @escaping (String?) -> Void) {
        let dataBase = Firestore.firestore()
        
        dataBase
            .collection("users")
            .document(user.uid)
            .setData([ "firstname": firstname,
                       "lastname": lastname,
                       "email": email
                     ]) { error in
                if let error { completion(error.localizedDescription) }
                else {

                }
            }
    }
    
    
    func resetPassword(completion: @escaping (String, Bool) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error {
                // Error occurred while resetting password
                completion(error.localizedDescription, true)
            } else {
                // Password reset email sent successfully
                completion("Password reset email sent.", false)
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
