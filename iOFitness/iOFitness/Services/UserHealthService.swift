//
//  UserHealthService.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import Foundation
import Firebase

class UserHealthService {
    static let shared = UserHealthService()
    private let db = Firestore.firestore()
    private let usersCollection = "users"
    
    private init() {}
    
    // Create User Health Document
    func createUserHealthDocument(userID: String, healthData: UserHealthModel, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let userHealthData: [String: Any] = [
            "height": healthData.height,
            "weight": healthData.weight,
            "age": healthData.age,
            "gender": healthData.gender,
            "fitnessGoal": healthData.fitnessGoal,
            "updated": healthData.updated
        ]
        
        db.collection("users").document(userID).collection("Health Record").document(healthData.updated).setData(userHealthData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    // Update user health data (document)
    func updateUserHealthData(userID: String, healthData: UserHealthModel, completion: @escaping (Result<Void, Error>) -> Void) {
        let userHealthData: [String: Any] = [
            "height": healthData.height,
            "weight": healthData.weight,
            "age": healthData.age,
            "gender": healthData.gender,
            "fitnessGoal": healthData.fitnessGoal,
            "updated": healthData.updated
        ]
        
        let userDocumentRef = db.collection(usersCollection).document(userID)
        
        userDocumentRef.updateData(userHealthData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    // Fetch all health data (collection) with real-time updates
    func fetchAllHealthData(userID: String, completion: @escaping (Result<[UserHealthModel], Error>) -> Void) -> ListenerRegistration {
        let collectionRef = db.collection(usersCollection).document(userID).collection("Health Record")
        
        let listener = collectionRef.addSnapshotListener { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let snapshot = snapshot else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data available"])))
                return
            }
            
            var healthsData: [UserHealthModel] = []
            
            for document in snapshot.documents {
                let height = document.data()["height"] as? Double ?? 0.0
                let weight = document.data()["weight"] as? Double ?? 0.0
                let age = document.data()["age"] as? Int ?? 0
                let gender = document.data()["gender"] as? String ?? ""
                let fitnessGoal = document.data()["fitnessGoal"] as? String ?? ""
                let updated = document.data()["updated"] as? String ?? ""
                
                let userHealth = UserHealthModel(height: height, weight: weight, age: age, gender: gender, fitnessGoal: fitnessGoal, updated: updated)
                healthsData.append(userHealth)
            }
            
            completion(.success(healthsData))
        }
        
        return listener
    }
}
