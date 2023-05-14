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
