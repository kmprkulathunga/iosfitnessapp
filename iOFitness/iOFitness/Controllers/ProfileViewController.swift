//
//  ProfileViewController.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import UIKit
import FirebaseFirestore

class ProfileViewController: UIViewController {
    private let profileView: ProfileView
    private var userModel: UserModel?
    private let currentUserID = AuthService.currentUser?.uid
    private var userDocumentListener: ListenerRegistration?
    
    init() {
        self.userModel = nil
        self.profileView = ProfileView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        startListeningForUserDataChanges()
    }

    
    private func setupUI() {
        view.backgroundColor = AppThemeData.colorBackgroundLight
        view.addSubview(profileView)
        
        profileView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileView.signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
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
                      let fitnessGoal = userData["fitnessGoal"] as? String,
                      let created = userData["created"] as? String,
                      let updated = userData["updated"] as? String else {
                    // Handle missing data or incorrect types
                    print("Invalid user data")
                    return
                }
                let userModel = UserModel(firstName: firstName, lastName: lastName, email: email, password: password, height: height, weight: weight, age: age, gender: gender, fitnessGoal: fitnessGoal, created: created, updated: updated)
                self?.userModel = userModel
                self?.profileView.configure(userModel: userModel)
            case .failure(let error):
                print("Failed to fetch user data: \(error)")
            }
        }
    }

    private func stopListeningForUserDataChanges() {
        userDocumentListener?.remove()
        userDocumentListener = nil
    }
    
    private func setupBindings() {
        // Account
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(editAccountDetails))
        profileView.editButtonAccount.addGestureRecognizer(tapGesture)
//        // Health
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(editHealthDetails))
        profileView.editButtonHealth.addGestureRecognizer(tapGesture2)
    }
    
    // Account
    @objc private func editAccountDetails() {
        print("editAccountDetails...")
    }
    
    // Health
    @objc private func editHealthDetails() {
        print("editHealthDetails...")
//        let nextViewController = UpdateHealthDetailsViewController(userHealthModel: UserHealthModel(height: userModel!.height, weight: userModel!.weight, age: userModel!.age, gender: userModel!.gender, fitnessGoal: userModel!.fitnessGoal, updated: userModel!.updated))
//        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // SignOut
    @objc private func signOutButtonTapped() {
        AuthService.signOut {result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.navigationController?.setViewControllers([LogInViewController()], animated: true)
                    print("User sign out!")
                }
            case .failure(let error):
                print("Error signing out: \(error.localizedDescription)")
            }
        }
    }
}
