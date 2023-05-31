//
//  UpdateProfileViewController.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import UIKit
import SnapKit
import MBProgressHUD

class UpdateProfileViewController: UIViewController {
    private let updateProfileView: UpdateProfileView
    let currentUserID = AuthService.currentUser?.uid
    private let userHealthModel: UserHealthModel
    
    init(userHealthModel: UserHealthModel) {
        self.userHealthModel = userHealthModel
        self.updateProfileView = UpdateProfileView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        customizeNavigationBar()
        customizeNavigationBarBackButton()
        setupBindings()
        updateProfileView.configure(userHealthModel: userHealthModel)
    }
    
    private func setupUI() {
        view.backgroundColor = AppThemeData.colorBackgroundLight
        view.addSubview(updateProfileView)
        
        // Title
        title = "Update Health Details"
        
        updateProfileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        updateProfileView.updateInfoButton.addTarget(self, action: #selector(updateInfoButtonTapped), for: .touchUpInside)
    }
    
    private func customizeNavigationBar() {
//        let customFont = AppThemeData.fontSizeHeadline ?? UIFont.systemFont(ofSize: 20)
        let customFont = UIFont.systemFont(ofSize: 20)
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: customFont,
            NSAttributedString.Key.foregroundColor: AppThemeData.colorTextDarkGray
        ]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    private func customizeNavigationBarBackButton() {
        // Back Button
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationItem.backBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = AppThemeData.colorTextDarkGray
        let attributes: [NSAttributedString.Key: Any] = [
//            NSAttributedString.Key.font: AppThemeData.fontSizeTextButton!,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold),
            NSAttributedString.Key.foregroundColor: AppThemeData.colorTextDarkGray
        ]
        backButton.setTitleTextAttributes(attributes, for: .normal)
    }
    
    
    @objc private func updateInfoButtonTapped() {
        let height = updateProfileView.heightTextField.text ?? ""
        let weight = updateProfileView.weightTextField.text ?? ""
        let genderIndex = updateProfileView.genderSegmentedControl.selectedSegmentIndex
        let gender = updateProfileView.genderSegmentedControl.titleForSegment(at: genderIndex) ?? ""
        let age = updateProfileView.ageTextField.text ?? ""
        let fitnessGoal = updateProfileView.fitnessGoalSegmentedControl.titleForSegment(at: genderIndex) ?? ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd:HH:mm:ss"
        let dateTimeNow = dateFormatter.string(from: Date())
        
        // let formValidator = FormValidator()
        // TODO: Validate button press later
        
        var heightValue: Double = 0.0
        if let heightDoubleValue = Double(height) {
            heightValue = heightDoubleValue
        } else if let heightIntValue = Int(height) {
            heightValue = Double(heightIntValue)
        } else {
            print("Invalid height value")
            return
        }
        
        var weightValue: Double = 0.0
        if let weightDoubleValue = Double(weight) {
            weightValue = weightDoubleValue
        } else if let weightIntValue = Int(weight) {
            weightValue = Double(weightIntValue)
        } else {
            print("Invalid weight value")
            return
        }
        
        if let ageValue = Int(age) {
            let userHealthModel = UserHealthModel(height: heightValue, weight: weightValue, age: ageValue, gender: gender, fitnessGoal: fitnessGoal, updated: dateTimeNow)
                print("---------- User Health Details ----------")
                print("Height: \(userHealthModel.height)")
                print("Weight: \(userHealthModel.weight)")
                print("Age: \(userHealthModel.age)")
                print("Gender: \(userHealthModel.gender)")
                print("FitnessGoal: \(userHealthModel.fitnessGoal)")
            updateUserDataToFirestore(userHealthModel: userHealthModel)
        } else {
            print("Invalid age value")
        }
    }
    
    // Update to user document
    private func updateUserDataToFirestore(userHealthModel: UserHealthModel) {
        
        let progressHUD = MBProgressHUD.showAdded(to: view, animated: true)
        progressHUD.label.text = "Saving..."
        
        guard let userID = AuthService.currentUser?.uid else {
            // Handle the case when the user ID is not available
            return
        }
        
        UserHealthService.shared.updateUserHealthData(userID: userID, healthData: userHealthModel) { result in
            DispatchQueue.main.async {
                progressHUD.hide(animated: true)

                switch result {
                case .success:
                    // Update successful
                    print("User health data updated successfully")
                    // Perform any additional actions or show success message
                    AppAlertDialog().showErrorAlert(viewController: self, error: "Profile Updated!", message: "User profile updated successfully")
                    
                    // Call storeHealthRecordInFirestore
                    guard let userID = AuthService.currentUser?.uid else {
                        // Handle the case when the user ID is not available
                        return
                    }

                    self.storeHealthRecordInFirestore(userID: userID, userHealthModel: userHealthModel) { success in
                        if success {
                            // Health record stored successfully
                            print("Health record stored in Firestore")
                            AppAlertDialog().showErrorAlert(viewController: self, error: "Health Data Updated!", message: "User health data updated successfully")
                        } else {
                            // Failed to store health record
                            print("Failed to store health record in Firestore")
                            AppAlertDialog().showErrorAlert(viewController: self, error: "Health Data Cannot Update!", message: "Failed to store health record")
                        }
                    }

                case .failure(let error):
                    // Update failed
                    print("Failed to update user health data: \(error)")
                    // Display an error message or handle the error gracefully
                    AppAlertDialog().showErrorAlert(viewController: self, error: "Health Data Cannot Update!", message: "Failed to update user health data")
                }
            }
        }
        
    }
    
    private func storeHealthRecordInFirestore(userID: String, userHealthModel: UserHealthModel, completion: @escaping (Bool) -> Void) {
        
//        UserHealthService.shared.createUserHealthDocument(userID: userID,  healthData: userHealthModel) { result in
//            switch result {
//            case .success:
//                print("User health data stored in Firestore")
//                completion(true)
//
//            case .failure(let error):
//                print("Failed to store user health data in Firestore:", error)
//                completion(false)
//            }
//        }
    }
    
}
