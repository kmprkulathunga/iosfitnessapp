//
//  AuthService.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import Foundation
import FirebaseAuth

struct AuthService {
    static func signUp(authModel: AuthModel, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: authModel.email, password: authModel.password) { (authResult, error) in
            if let user = authResult?.user {
                completion(.success(user))
            } else if let error = error {
                if error.localizedDescription == "The email address is already in use by another account." {
                    let emailError = NSError(domain: "iOFitnsess.AuthService", code: 0, userInfo: [
                        NSLocalizedDescriptionKey: "The email address is already in use by another account."
                    ])
                    completion(.failure(emailError))
                } else {
                    completion(.failure(error))
                }
            } else {
                // Handle unexpected case or provide a default error
                let defaultError = NSError(domain: "iOFitnsess.AuthService", code: 0, userInfo: [
                    NSLocalizedDescriptionKey: "An unexpected error occurred during sign up."
                ])
                completion(.failure(defaultError))
            }
        }
    }
    
    static func signIn(authModel: AuthModel, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: authModel.email, password: authModel.password) { (authResult, error) in
            if let user = authResult?.user {
                completion(.success(user))
            } else if let error = error {
                if error.localizedDescription == "The password is invalid or the user does not have a password." {
                    let emailError = NSError(domain: "iOFitnsess.AuthService", code: 0, userInfo: [
                        NSLocalizedDescriptionKey: "The password is invalid or the user does not have a password."
                    ])
                    completion(.failure(emailError))
                } else {
                    completion(.failure(error))
                }
                //TODO: Validate: "There is no user record corresponding to this identifier. The user may have been deleted."
            } else {
                // Handle unexpected case or provide a default error
                let defaultError = NSError(domain: "iOFitnsess.AuthService", code: 0, userInfo: [
                    NSLocalizedDescriptionKey: "An unexpected error occurred during sign in."
                ])
                completion(.failure(defaultError))
            }
        }
    }
    
    static func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    static var currentUser: User? {
        return Auth.auth().currentUser
    }
}

