//
//  LogInViewController.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import UIKit
import SnapKit
import MBProgressHUD

class LogInViewController: UIViewController {
    private let logInView = LogInView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        view.backgroundColor = AppThemeData.colorBackgroundLight
        view.addSubview(logInView)
        
        logInView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupBindings() {
        logInView.logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(switchToSignUp))
        logInView.switchLoginButton.addGestureRecognizer(tapGesture)
    }
    
    @objc private func logInButtonTapped() {
        let email = logInView.emailTextField.text ?? ""
        let password = logInView.passwordTextField.text ?? ""
        
        
        let authModel = AuthModel(email: email, password: password)

        let formValidator = FormValidateHelper()
        if formValidator.validateLogIn(viewController: self, authModel: authModel) {
            print("---------- User Details ----------")
            print("Email: ", authModel.email)
            print("Password: ", authModel.password)
            print("Login....")

            let progressHUD = MBProgressHUD.showAdded(to: view, animated: true)
            progressHUD.label.text = "Loging..."

            AuthService.signIn(authModel: authModel) { [weak self] result in
                DispatchQueue.main.async {

                    switch result {
                    case .success(let user):
                        // User signed in successfully
                        progressHUD.hide(animated: true)
                        print("User signed in:", user)
                        self?.navigationController?.setViewControllers([MainTabBarController()], animated: true)

                    case .failure(let error):
                        // Handle sign in error
                        progressHUD.hide(animated: true)
                        print("Sign in error:", error)
                        if error.localizedDescription == "The password is invalid or the user does not have a password." {
                            AppAlertDialog().showErrorAlert(viewController: self!, error: "Error", message: "Login failed. The password is invalid or the user does not have a password.")
                        }
                        AppAlertDialog().showErrorAlert(viewController: self!, error: "Error", message: "Login failed. Please try again.")
                    }
                }
            }
        }
    }
    
    @objc private func switchToSignUp() {
        let nextViewController = SignUpViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}
