//
//  HomeViewController.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import UIKit
import FirebaseFirestore

class HomeViewController: UIViewController {
    private let homeView: HomeView
    private var userModel: UserModel?
    private let currentUserID = AuthService.currentUser?.uid
    private var userDocumentListener: ListenerRegistration?
    
    init() {
        self.userModel = nil
        self.homeView = HomeView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startListeningForUserDataChanges()
    }
    
    private func setupUI() {
        view.backgroundColor = AppThemeData.colorBackgroundLight
        view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func startListeningForUserDataChanges() {
        userDocumentListener = UserService.shared.fetchUserDocument(userID: currentUserID!) { [weak self] result in
            switch result {
            case .success(let userData):
                guard let firstName = userData["firstName"] as? String,
                      let lastName = userData["lastName"] as? String,
                      let email = userData["email"] as? String,
                      let password = userData["password"] as? String,
                      let height = userData["height"] as? Double,
                      let weight = userData["weight"] as? Double,
                      let age = userData["age"] as? Int,
                      let gender = userData["gender"] as? String,
                      let fitnessGoal = userData["fitnessGoal"] as? String else {
                    // Handle missing data or incorrect types
                    print("Invalid user data")
                    return
                }
                let userModel = UserModel(firstName: firstName, lastName: lastName, email: email, password: password, height: height, weight: weight, age: age, gender: gender, fitnessGoal: fitnessGoal, created: DateTimeHelper().getCurrentDateTime, updated: DateTimeHelper().getCurrentDateTime)
                self?.userModel = userModel
                self?.homeView.configure(userModel: userModel)
                // Update BMI value
                self?.homeView.updateBMIValue(height: height, weight: weight)
            case .failure(let error):
                print("Failed to fetch user data: \(error)")
            }
        }
    }
    
    private func stopListeningForUserDataChanges() {
        userDocumentListener?.remove()
        userDocumentListener = nil
    }
}

