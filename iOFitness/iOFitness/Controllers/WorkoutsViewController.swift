//
//  WorkoutsViewController.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import UIKit
import FirebaseFirestore

class WorkoutsViewController: UIViewController, WorkoutLevelSelectionDelegate {
    private let workoutsView: WorkoutsView
    private var workoutModel: WorkoutModel?
    private var workoutLevelCollectionListener: ListenerRegistration?
    
    init() {
        self.workoutModel = nil
        self.workoutsView = WorkoutsView()
        self.workoutsView.configure()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutsView.selectionDelegate = self
        setupUI()
        workoutDataPreloader()
        startListeningForWorkoutLevelDataChanges()
        print("----- WorkoutsViewController -----")
    }
    
    // Workout Data Preloader
    private func workoutDataPreloader(){
        
        // MARK: Abs
        
        let cardAbsBeginner = CardModel(id: "Abs", title: "Beginner", caption: "N/A workouts", value: "N/A mins", image: "")
        let cardAbsIntermediate = CardModel(id: "Abs", title: "Intermediate", caption: "N/A workouts", value: "N/A mins", image: "")
        let cardAbsAdvanced = CardModel(id: "Abs", title: "Advanced", caption: "N/A workouts", value: "N/A mins", image: "")
        self.workoutsView.absWorkoutCards = [cardAbsBeginner, cardAbsIntermediate, cardAbsAdvanced]
        
        // MARK: Chest
        
        let cardChestBeginner = CardModel(id: "Chest", title: "Beginner", caption: "N/A workouts", value: "N/A mins", image: "")
        let cardChestIntermediate = CardModel(id: "Chest", title: "Intermediate", caption: "N/A workouts", value: "N/A mins", image: "")
        let cardChestAdvanced = CardModel(id: "Chest", title: "Advanced", caption: "N/A workouts", value: "N/A mins", image: "")
        self.workoutsView.chestWorkoutCards = [cardChestBeginner, cardChestIntermediate, cardChestAdvanced]
        
        // MARK: Arm
        
        let cardArmBeginner = CardModel(id: "Arm", title: "Beginner", caption: "N/A workouts", value: "N/A mins", image: "")
        let cardArmIntermediate = CardModel(id: "Arm", title: "Intermediate", caption: "N/A workouts", value: "N/A mins", image: "")
        let cardArmAdvanced = CardModel(id: "Arm", title: "Advanced", caption: "N/A workouts", value: "N/A mins", image: "")
        self.workoutsView.armWorkoutCards = [cardArmBeginner, cardArmIntermediate, cardArmAdvanced]
        
        // MARK: Leg
        
        let cardLegBeginner = CardModel(id: "Leg", title: "Beginner", caption: "N/A workouts", value: "N/A mins", image: "")
        let cardLegIntermediate = CardModel(id: "Leg", title: "Intermediate", caption: "N/A workouts", value: "N/A mins", image: "")
        let cardLegAdvanced = CardModel(id: "Leg", title: "Advanced", caption: "N/A workouts", value: "N/A mins", image: "")
        self.workoutsView.legWorkoutCards = [cardLegBeginner, cardLegIntermediate, cardLegAdvanced]
        
        // MARK: Shoulder & Back Workouts
        
        let cardShoulderNBackBeginner = CardModel(id: "Shoulder & Back", title: "Beginner", caption: "N/A workouts", value: "N/A mins", image: "")
        let cardShoulderNBackIntermediate = CardModel(id: "Shoulder & Back", title: "Intermediate", caption: "N/A workouts", value: "N/A mins", image: "")
        let cardShoulderNBackAdvanced = CardModel(id: "Shoulder & Back", title: "Advanced", caption: "N/A workouts", value: "N/A mins", image: "")
        self.workoutsView.shoulderNBackWorkoutCards = [cardShoulderNBackBeginner, cardShoulderNBackIntermediate, cardShoulderNBackAdvanced]
    }
    
    // Fetch Data from Firestore
    private func startListeningForWorkoutLevelDataChanges() {
        workoutLevelCollectionListener = WorkoutService.shared.fetchAllWorkouts { [weak self] result in
            switch result {
            case .success(let workouts):
                for workout in workouts {
                    
                    let cardBeginner = CardModel(id: workout.muscleGroup, title: "Beginner", caption: "\(workout.beginner.count) workouts", value: "\(workout.time[0]) mins", image: workout.images[0])
                    
                    let cardIntermediate = CardModel(id: workout.muscleGroup, title: "Intermediate", caption: "\(workout.intermediate.count) workouts", value: "\(workout.time[1]) mins", image: workout.images[1])
                    
                    let cardAdvanced = CardModel(id: workout.muscleGroup, title: "Advanced", caption: "\(workout.advanced.count) workouts", value: "\(workout.time[2]) mins", image: workout.images[2])
                    
                    if workout.muscleGroup == "Abs" {
                        self?.workoutsView.absWorkoutCards = [cardBeginner, cardIntermediate, cardAdvanced]
                        self?.workoutsView.collectionViewAbs.reloadData()
                    } else if workout.muscleGroup == "Chest" {
                        self?.workoutsView.chestWorkoutCards = [cardBeginner, cardIntermediate, cardAdvanced]
                        self?.workoutsView.collectionViewChest.reloadData()
                    } else if workout.muscleGroup == "Arm" {
                        self?.workoutsView.armWorkoutCards = [cardBeginner, cardIntermediate, cardAdvanced]
                        self?.workoutsView.collectionViewArm.reloadData()
                    } else if workout.muscleGroup == "Leg" {
                        self?.workoutsView.legWorkoutCards = [cardBeginner, cardIntermediate, cardAdvanced]
                        self?.workoutsView.collectionViewLeg.reloadData()
                    } else if workout.muscleGroup == "Shoulder & Back" {
                        self?.workoutsView.shoulderNBackWorkoutCards = [cardBeginner, cardIntermediate, cardAdvanced]
                        self?.workoutsView.collectionViewShoulderNBack.reloadData()
                    }
                }
            case .failure(let error):
                print("Error fetching workouts: \(error)")
            }
        }
        
    }
    
    
    private func stopListeningForWorkoutDataChanges() {
        workoutLevelCollectionListener?.remove()
        workoutLevelCollectionListener = nil
    }
    
    private func setupUI() {
        view.backgroundColor = AppThemeData.colorBackgroundLight
        view.addSubview(workoutsView)
        workoutsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // Implement the delegate method
    func didSelectWorkout(cardModel: CardModel) {
        print(cardModel)
        let aboutWorkoutViewController = AboutWorkoutViewController(cardModel: cardModel)
        // Present or push the `aboutWorkoutViewController` as needed
        navigationController?.pushViewController(aboutWorkoutViewController, animated: true)
    }
}
