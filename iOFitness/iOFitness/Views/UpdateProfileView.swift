//
//  UpdateProfileView.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import UIKit
import SnapKit

class UpdateProfileView: UIView {
    let heightLabel = AppLabel.subheadline()
    let weightLabel = AppLabel.subheadline()
    let genderLabel = AppLabel.subheadline()
    let ageLabel = AppLabel.subheadline()
    let fitnessGoalLabel = AppLabel.subheadline()
    
    let heightTextField = AppTextField.standardTextField(placeholder: "174")
    let weightTextField = AppTextField.standardTextField(placeholder: "80")
    let ageTextField = AppTextField.standardTextField(placeholder: "24")
    
    let genderSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Male", "Female"])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    let fitnessGoalSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Weight Loss", "Muscle Build", "Keep Fit"])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    var healthConditions: [String] = []
    
    let updateInfoButton = AppButton.primaryButton(title: "Update Details")
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func configure(userHealthModel: UserHealthModel) {
        heightLabel.text = "Height (cm)"
        weightLabel.text = "Weight (Kg)"
        genderLabel.text = "Gender"
        ageLabel.text = "Age (Years)"
        fitnessGoalLabel.text = "Health Conditions"
        
        heightTextField.text = String(userHealthModel.height)
        weightTextField.text = String(userHealthModel.weight)
        ageTextField.text = String(userHealthModel.age)
        
        if userHealthModel.gender == "Female" {
            genderSegmentedControl.selectedSegmentIndex = 1
        } else {
            genderSegmentedControl.selectedSegmentIndex = 0
        }
    }
    
    private func setupUI() {
        addSubview(heightLabel)
        addSubview(weightLabel)
        addSubview(genderLabel)
        addSubview(ageLabel)
        addSubview(heightTextField)
        addSubview(weightTextField)
        addSubview(genderSegmentedControl)
        addSubview(ageTextField)
        addSubview(fitnessGoalLabel)
        addSubview(fitnessGoalSegmentedControl)
        addSubview(updateInfoButton)
    
        heightLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        heightTextField.snp.makeConstraints { make in
            make.top.equalTo(heightLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        weightLabel.snp.makeConstraints { make in
            make.top.equalTo(heightTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        weightTextField.snp.makeConstraints { make in
            make.top.equalTo(weightLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(weightTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        genderSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(30)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(genderSegmentedControl.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        ageTextField.snp.makeConstraints { make in
            make.top.equalTo(ageLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        fitnessGoalLabel.snp.makeConstraints { make in
            make.top.equalTo(ageTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        fitnessGoalSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(fitnessGoalLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        updateInfoButton.snp.makeConstraints { make in
            make.top.equalTo(fitnessGoalSegmentedControl.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
    }
}
