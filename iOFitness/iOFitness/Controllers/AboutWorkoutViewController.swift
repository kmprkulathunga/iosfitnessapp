//
//  AboutWorkoutViewController.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-31.
//

import UIKit
import SnapKit
import FirebaseFirestore

class AboutWorkoutViewController: UIViewController, WorkoutSelectionDelegate {
    private let aboutWorkoutView: AboutWorkoutView
    private let cardModel: CardModel
    private let muscleGroup: String?
    private let level: String?
    private var workoutCollectionListener: ListenerRegistration?
    private var workoutDocumentListener: ListenerRegistration?
    private var workoutCards: [CardModel] = []

    init(cardModel: CardModel) {
        self.cardModel = cardModel
        self.muscleGroup = cardModel.id
        self.level = cardModel.title
        self.aboutWorkoutView = AboutWorkoutView()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        aboutWorkoutView.selectionDelegate = self
        setupUI()
        aboutWorkoutView.configure(cardModel: cardModel)
        customizeNavigationBarBackButton()
        startListeningForWorkoutDataChanges()
        print("----- AboutWorkoutViewController -----")
    }
    
    // Fetch Data from Firestore
    private func startListeningForWorkoutDataChanges() {
        workoutCollectionListener = WorkoutService.shared.fetchAllWorkoutLevelExcersises(cardModel: cardModel, completion: { [weak self] result in
            switch result {
            case .success(let workouts):
                self?.workoutCards = workouts.map { workout in
                    return CardModel(id: workout.name, title: workout.name, caption: workout.reps, value: "", image: workout.image)
                }
                self?.aboutWorkoutView.workoutCards = self?.workoutCards ?? []
                
                // Calculate the new collection view height based on the number of cards
                let cardHeight: CGFloat = 80
                let verticalSpacing: CGFloat = 16
                let numberOfCards = CGFloat(self?.workoutCards.count ?? 0)
                let collectionViewHeight = (cardHeight * numberOfCards) + (verticalSpacing * (numberOfCards - 1))
                
                // Update the collection view height constraint
                self?.aboutWorkoutView.collectionView.snp.updateConstraints { make in
                    make.height.equalTo(collectionViewHeight)
                }
                
                // Reload the collection view
                self?.aboutWorkoutView.collectionView.reloadData()
                
            case .failure(let error):
                print("Error fetching workouts: \(error)")
            }
        })
    }

    private func setupUI() {
        view.backgroundColor = AppThemeData.colorBackgroundLight
        title = cardModel.id + " - " + cardModel.title
        view.addSubview(aboutWorkoutView)
        aboutWorkoutView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func customizeNavigationBarBackButton() {
        // Back Button
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationItem.backBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = AppThemeData.colorTextDarkGray
        let customFont = UIFont.systemFont(ofSize: 20)
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: customFont,
            NSAttributedString.Key.foregroundColor: AppThemeData.colorTextDarkGray
        ]
        backButton.setTitleTextAttributes(attributes, for: .normal)
    }
    
    // Implement the delegate method
    func didSelectWorkout(cardModel: CardModel) {
        print(cardModel)
        
        print("workouts/" + muscleGroup! + "/" + level! + "/" + cardModel.id)
        
        // Fetch the corresponding workouts from the Firestore based on the selected card
        workoutDocumentListener = WorkoutService.shared.fetchSingleWorkoutLevelExcersises(muscleGroup: muscleGroup!, level: level!, excersise: cardModel.id) {result in
            switch result {
            case .success(let workoutModel):
                print(workoutModel) // Print the workoutModel for each workout
                let nextViewController = AboutExViewController(workoutLevelExcersiseModel: WorkoutLevelExcersiseModel(name: workoutModel.name, description: workoutModel.description, reps: workoutModel.reps, image: workoutModel.image, video: workoutModel.video), level: self.level!, muscleGroup: self.muscleGroup!)
                self.navigationController?.pushViewController(nextViewController, animated: true)
            case .failure(let error):
                print("Error fetching workout: \(error)")
            }
        }
    }
    
    
    private func stopListeningForWorkoutDataChanges() {
        workoutCollectionListener?.remove()
        workoutCollectionListener = nil
        workoutDocumentListener?.remove()
        workoutDocumentListener = nil
    }
}
