//
//  WorkoutService.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import Foundation
import FirebaseFirestore

struct WorkoutService {
    static let shared = WorkoutService()
    
    private let db = Firestore.firestore()
    private let workoutsCollection = "workouts"
    
    private init() {}
    
    // Fetch all workouts (collection)
    // e.g., workouts/
    func fetchAllWorkouts(completion: @escaping (Result<[WorkoutModel], Error>) -> Void) -> ListenerRegistration? {
        return db.collection(workoutsCollection).addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            var workouts: [WorkoutModel] = []
            
            for document in querySnapshot?.documents ?? [] {
                if let muscleGroup = document.data()["muscleGroup"] as? String,
                   let description = document.data()["description"] as? String,
                   let beginner = document.data()["beginner"] as? Array<String>,
                   let advanced = document.data()["advanced"] as? Array<String>,
                   let intermediate = document.data()["intermediate"] as? Array<String>,
                   let images = document.data()["images"] as? Array<String>,
                   let time = document.data()["time"] as? Array<Int> {
                    
                    let workout = WorkoutModel(muscleGroup: muscleGroup, description: description, beginner: beginner, advanced: advanced, intermediate: intermediate, images: images, time: time)
                    
                    workouts.append(workout)
                }
            }
            
            completion(.success(workouts))
        }
    }
    
    // Fetch single workout (document)
    // e.g., workouts/Abs/
    func fetchSingleWorkout(workoutID: String, completion: @escaping (Result<WorkoutModel, Error>) -> Void) -> ListenerRegistration {
        let workoutDocumentRef = db.collection(workoutsCollection).document(workoutID)

        return workoutDocumentRef.addSnapshotListener { (documentSnapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let documentData = documentSnapshot?.data(),
                  let muscleGroup = documentData["muscleGroup"] as? String,
                  let description = documentData["description"] as? String,
                  let beginner = documentData["beginner"] as? Array<String>,
                  let advanced = documentData["advanced"] as? Array<String>,
                  let intermediate = documentData["intermediate"] as? Array<String>,
                  let images = documentData["images"] as? Array<String>,
                  let time = documentData["time"] as? Array<Int>
            else {
                let noDataError = NSError(domain: "FitnessFlow.WorkoutService", code: 0, userInfo: [
                    NSLocalizedDescriptionKey: "No workout data found"
                ])
                completion(.failure(noDataError))
                return
            }

            let workout = WorkoutModel(muscleGroup: muscleGroup, description: description, beginner: beginner, advanced: advanced, intermediate: intermediate, images: images, time: time)

            completion(.success(workout))
        }
    }
    
    // Fetch all workout level excersies (collection)
    // e.g., workouts/Abs/Beginner/
    func fetchAllWorkoutLevelExcersises(cardModel: CardModel, completion: @escaping (Result<[WorkoutLevelExcersiseModel], Error>) -> Void) -> ListenerRegistration? {
        return db.collection(workoutsCollection).document(cardModel.id).collection(cardModel.title).addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            var workoutLevelExcersies: [WorkoutLevelExcersiseModel] = []
            
            guard let documents = querySnapshot?.documents else {
                completion(.success(workoutLevelExcersies))
                return
            }
            
            for document in documents {
                if let name = document.data()["name"] as? String,
                   let description = document.data()["description"] as? String,
                   let reps = document.data()["reps"] as? String,
                   let image = document.data()["image"] as? String,
                   let video = document.data()["video"] as? String {
                    
                    let workoutLevelData = WorkoutLevelExcersiseModel(name: name, description: description, reps: reps, image: image, video: video)
                    
                    workoutLevelExcersies.append(workoutLevelData)
                }
            }
            
            completion(.success(workoutLevelExcersies))
        }
    }
    
    // Fetch single workout level excersies (document)
    // e.g., workouts/Abs/Beginner/Jumping Jacks
    func fetchSingleWorkoutLevelExcersises(muscleGroup: String, level: String, excersise: String, completion: @escaping (Result<WorkoutLevelExcersiseModel, Error>) -> Void) -> ListenerRegistration {
        let workoutDocumentRef = db.collection(workoutsCollection).document(muscleGroup).collection(level).document(excersise)

        return workoutDocumentRef.addSnapshotListener { (documentSnapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let documentData = documentSnapshot?.data(),
                  let name = documentData["name"] as? String,
                  let description = documentData["description"] as? String,
                  let reps = documentData["reps"] as? String,
                  let image = documentData["image"] as? String,
                  let video = documentData["video"] as? String
            else {
                let noDataError = NSError(domain: "FitnessFlow.WorkoutService", code: 0, userInfo: [
                    NSLocalizedDescriptionKey: "No workout data found"
                ])
                completion(.failure(noDataError))
                return
            }

            let workout = WorkoutLevelExcersiseModel(name: name, description: description, reps: reps, image: image, video: video)

            completion(.success(workout))
        }
    }
}
 
