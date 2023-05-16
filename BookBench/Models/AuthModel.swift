//
//  AuthModel.swift
//  BookBench
//
//  Created by Mehdi Karami on 5/16/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

// MARK: - Auth Model

struct AuthModel {
    
    /// Logs in the user with the provided email and password.
    /// Uses the Firebase Auth module to perform the login operation.
    /// - Parameters:
    ///   - email: A string representing the user's email address.
    ///   - password: A string representing the user's password.
    ///   - completion:  A closure that takes a string parameter and returns void.
    ///    This closure will be called after the login operation completes,
    ///    providing either an error message or the description of the authentication result.
    /// - Important: The `email` and `password` properties should be set before calling this function.
    /// - Requires: Firebase/Auth module
    func logIn(email: String, password: String, completion: @escaping (String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error {
                completion(error.localizedDescription)
            } else if let authResult {
                // Saves the authentication token for the current user in the user defaults.
                saveAuthToken()
                completion(authResult.description)
            }
        }
    }
    
    /// Signs up a new user with the provided information.
    /// Uses the Firebase Auth and Firestore modules to perform the signup operation and save additional user info.
    /// - Parameters:
    ///   - firstname: A string representing the user's first name.
    ///   - lastname:  A string representing the user's last name.
    ///   - email: A string representing the user's email address.
    ///   - password: A string representing the user's password.
    ///   - repeatedPassword: A string representing the repeated password for confirmation.
    ///   - completion: A closure that takes an optional String parameter. It will be called after the signup attempt is completed.
    ///    If an error occurs during the signup process, the error description will be passed as a parameter.
    ///    If the signup is successful, the parameter will be nil.
    /// - Important: The `firstname`, `lastname`, `password`, `repeatedPassword`, and `email` properties should be set before calling this function.
    /// - Requires: Firebase/Auth and Firebase/Firestore modules
    func signUp(firstname: String, lastname: String,
                email: String,
                password: String, repeatedPassword: String,
                completion: @escaping (String) -> Void) {
        
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
                saveAdditionalUserInfo(for: user, completion: completion)
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
        func saveAdditionalUserInfo(for user: User, completion: @escaping (String) -> Void) {
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
                        // Saves the authentication token for the current user in the user defaults.
                        saveAuthToken()
                        completion("Success")
                    }
                }
        }
    }
    
    /// Sends a password reset email to the user with the provided email address.
    /// - Parameters:
    ///   - email: A string representing the user's email address.
    ///   - completion: A closure that takes two parameters: a string and a boolean. It will be called after the password reset attempt is completed.
    /// The string parameter represents either an error message or a success message, depending on the reset operation's outcome.
    /// The boolean parameter indicates whether an error occurred (true) or the reset email was sent successfully (false).
    /// - Note: The completion closure is called asynchronously, once the password reset operation is finished. It provides the result of the password reset attempt,
    /// including an error message if applicable and a boolean value indicating success or failure.
    func resetPassword(email: String, completion: @escaping (String, Bool) -> Void) {
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
    
    /// Saves the authentication token for the current user in the user defaults.
    /// - Note: This function requires a currently signed-in user. If no user is signed in, the function will return without saving the token.
    /// The authentication token is retrieved using the getIDToken method of the current user.
    /// The retrieved token is then saved in the user defaults using the key "AuthToken".
    /// If an error occurs while retrieving the token, the error description will be printed to the console.
    func saveAuthToken() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        user.getIDToken(completion: { token, error in
            guard let token = token, error == nil else {
                // Handle error
                print("Failed to retrieve ID token: \(error?.localizedDescription ?? "")")
                return
            }
            UserDefaults.standard.set(token, forKey: "AuthToken")
        })
    }
}
