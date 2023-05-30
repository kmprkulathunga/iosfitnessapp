//
//  UserService.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import Foundation
import FirebaseFirestore

struct UserService {
    static let shared = UserService()
    
    private let db = Firestore.firestore()
    private let usersCollection = "users"
    
    private init() {}
    
    // Create single user (document)
    func createUserDocument(userID: String, data: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        let userDocumentRef = db.collection(usersCollection).document(userID)
        userDocumentRef.setData(data, merge: true) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    // Fetch single user (document)
    // e.g., users/uid/
    func fetchUserDocument(userID: String, completion: @escaping (Result<[String: Any], Error>) -> Void) -> ListenerRegistration {
        let userDocumentRef = db.collection(usersCollection).document(userID)
        return userDocumentRef.addSnapshotListener { (documentSnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let documentData = documentSnapshot?.data() {
                completion(.success(documentData))
            } else {
                let noDataError = NSError(domain: "iOFitness.FirestoreService", code: 0, userInfo: [
                    NSLocalizedDescriptionKey: "No user data found"
                ])
                completion(.failure(noDataError))
            }
        }
    }
}
