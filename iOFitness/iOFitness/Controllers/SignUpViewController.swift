//
//  SignUpViewController.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import UIKit
import SnapKit
//import MBProgressHUD

class SignUpViewController: UIViewController {
    private let signUpView = SignUpView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        navigationController?.navigationBar.tintColor = AppThemeData.colorTextDarkGray
    }
    
    private func setupUI() {
        view.backgroundColor = AppThemeData.colorBackgroundLight
        view.addSubview(signUpView)
        
        signUpView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupBindings() {
        signUpView.continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    @objc private func continueButtonTapped() {
        let firstName = signUpView.firstNameTextField.text ?? ""
        let lastName = signUpView.lastNameTextField.text ?? ""
        let email = signUpView.emailTextField.text ?? ""
        let password = signUpView.passwordTextField.text ?? ""
        let confirmPassword = signUpView.confirmPasswordTextField.text ?? ""
        
        let userAccountModel = UserAccountModel(firstName: firstName, lastName: lastName, email: email, password: password)

        let formValidator = FormValidateHelper()
        if formValidator.validateSignUp(viewController: self, userAccountModel: userAccountModel, confirmPassword: confirmPassword) {
            print("---------- User Account Model ----------")
            print("First Name: ", userAccountModel.firstName)
            print("Last Name: ", userAccountModel.lastName)
            print("Email: ", userAccountModel.email)
            print("Password: ", userAccountModel.password)
            print("Confirm Password: ", confirmPassword)

            // Navigate to HealthDataViewController
            let nextViewController = HealthViewController(userAccountModel: userAccountModel)
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}

