//
//  SignUpView.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import UIKit
import SnapKit

class SignUpView: UIView {
    
    let authHeader = AppHeader()
    
    let firstNameLabel = AppLabel.subheadline()
    let lastNameLabel = AppLabel.subheadline()
    let emailLabel = AppLabel.subheadline()
    let passwordLabel = AppLabel.subheadline()
    let confirmPasswordLabel = AppLabel.subheadline()
    
    let firstNameTextField = AppTextField.standardTextField(placeholder: "First Name")
    let lastNameTextField = AppTextField.standardTextField(placeholder: "Last Name")
    let emailTextField = AppTextField.standardTextField(placeholder: "Email")
    let passwordTextField = AppTextField.passwordTextField(placeholder: "Password")
    let confirmPasswordTextField = AppTextField.passwordTextField(placeholder: "Confirm Password")
    
    let continueButton = AppButton.primaryButton(title: "Setup Health Details")
    
    
    init() {
        super.init(frame: .zero)
        setupUI()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        firstNameLabel.text = "First Name"
        lastNameLabel.text = "Last Name"
        emailLabel.text = "Email"
        passwordLabel.text = "Password"
        confirmPasswordLabel.text = "Confirm Password"
    }
    
    private func setupUI() {
        addSubview(authHeader)
        addSubview(firstNameLabel)
        addSubview(firstNameTextField)
        addSubview(lastNameLabel)
        addSubview(lastNameTextField)
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        addSubview(confirmPasswordLabel)
        addSubview(confirmPasswordTextField)
        addSubview(continueButton)
        
        authHeader.configure(title: "Sign Up", caption: "Create your account", imageName: "iOFitness.png")
        
        authHeader.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(88)
        }
        
        firstNameLabel.snp.makeConstraints { make in
            make.top.equalTo(authHeader.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        firstNameTextField.snp.makeConstraints { make in
            make.top.equalTo(firstNameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        lastNameLabel.snp.makeConstraints { make in
            make.top.equalTo(firstNameTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        lastNameTextField.snp.makeConstraints { make in
            make.top.equalTo(lastNameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(lastNameTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        confirmPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
    }
}
