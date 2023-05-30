//
//  HealthViewController.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import UIKit
import SnapKit
import MBProgressHUD

class HealthViewController: UIViewController {
    private let healthView: HealthView
    
    private let userAccountModel: UserAccountModel
    
    init(userAccountModel: UserAccountModel) {
        self.userAccountModel = userAccountModel
        self.healthView = HealthView()
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
    }
    
    private func setupUI() {
        view.backgroundColor = AppThemeData.colorBackgroundLight
        view.addSubview(healthView)
        
        // Title
        title = "Add Health Details"
        
        healthView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        healthView.continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    private func customizeNavigationBar() {
        let customFont = AppThemeData.fontSizeHeadline ?? UIFont.systemFont(ofSize: 20)
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
            NSAttributedString.Key.font: AppLabel.callout(),
            NSAttributedString.Key.foregroundColor: AppThemeData.colorTextDarkGray
        ]
        backButton.setTitleTextAttributes(attributes, for: .normal)
    }
    
    
    @objc private func continueButtonTapped() {
        let height = healthView.heightTextField.text ?? ""
        let weight = healthView.weightTextField.text ?? ""
        let genderIndex = healthView.genderSegmentedControl.selectedSegmentIndex
        let gender = healthView.genderSegmentedControl.titleForSegment(at: genderIndex) ?? ""
        let fitnessGoal = healthView.fitnessGoalSegmentedControl.titleForSegment(at: genderIndex) ?? ""
        let age = healthView.ageTextField.text ?? ""
        
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
            print("---------- User Health Model ----------")
            print("Height: ", userHealthModel.height)
            print("Weight: ", userHealthModel.weight)
            print("Gender: ", userHealthModel.gender)
            print("Age: ", userHealthModel.age)
            print("Fitness Goal: ", userHealthModel.fitnessGoal)
            
            
            let userModel = UserModel(firstName: userAccountModel.firstName, lastName: userAccountModel.lastName, email: userAccountModel.email, password: userAccountModel.password, height: userHealthModel.height, weight: userHealthModel.weight, age: userHealthModel.age, gender: userHealthModel.gender, fitnessGoal: userHealthModel.fitnessGoal, created: DateTimeHelper().getCurrentDateTime, updated: DateTimeHelper().getCurrentDateTime)
            
            print("---------- User Model ----------")
            print("First Name: ", userModel.firstName)
            print("Last Name: ", userModel.lastName)
            print("Email: ", userModel.email)
            print("Password: ", userModel.password)
            print("Height: ", userModel.height)
            print("Weight: ", userModel.weight)
            print("Gender: ", userModel.gender)
            print("Age: ", userModel.age)
            print("Fitness Goal: ", userModel.fitnessGoal)
            print("Created: ", userModel.created)
            print("Update: ", userModel.updated)
            
            
            // Firebase Service
            setFirebaseService(userModel: userModel)
            
        } else {
            print("Invalid age value")
        }
    }
    
    // Firebase Service
    private func setFirebaseService(userModel: UserModel){
        print("Signing Up....")
        
        let progressHUD = MBProgressHUD.showAdded(to: view, animated: true)
        progressHUD.label.text = "Signing up..."
        
        let authModel = AuthModel(email: userModel.email, password: userModel.password)
        
        signUpUser(authModel: authModel, userModel: userModel) { [weak self] success in
            progressHUD.hide(animated: true)
            
            if success {
                print("User signed up and data stored in Firestore")
//                let homeViewController = MainTabBarController()
//                self?.navigationController?.setViewControllers([homeViewController], animated: true)
            } else {
                print("Sign up failed or failed to store user data in Firestore")
                // Show appropriate error message or handle the error
            }
        }
    }
    
    private func signUpUser(authModel: AuthModel, userModel: UserModel, completion: @escaping (Bool) -> Void) {
            AuthService.signUp(authModel: authModel) { [weak self] result in
                switch result {
                case .success(let user):
                    // User signed up successfully
                    print("User signed up:", user)
                    self?.storeUserDataInFirestore(userID: user.uid, userModel: userModel, completion: completion)
                    
                case .failure(let error):
                    // Handle sign up error
                    print("Sign up error:", error)
                    completion(false)
                }
            }
        }
        
        private func storeUserDataInFirestore(userID: String, userModel: UserModel, completion: @escaping (Bool) -> Void) {
            let userData = [
                "firstName": userModel.firstName,
                "lastName": userModel.lastName,
                "email": userModel.email,
                "password": userModel.password,
                
                "height": userModel.height,
                "weight": userModel.weight,
                "age": userModel.age,
                "gender": userModel.gender,
                "fitnessGoal": userModel.fitnessGoal,
                "created": userModel.created,
                "updated": userModel.updated
            ] as [String : Any]
            
            UserService.shared.createUserDocument(userID: userID, data: userData) { result in
                switch result {
                case .success:
                    print("User data stored in Firestore")
                    completion(true)
                    
                case .failure(let error):
                    print("Failed to store user data in Firestore:", error)
                    completion(false)
                }
            }
        }
    
}
