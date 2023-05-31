//
//  HomeView.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import UIKit
import SnapKit

class HomeView: UIView {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = AppThemeData.colorTextBlack
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    let greetingsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = AppThemeData.colorTextPrimary
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
//    let userNameLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.textColor = AppThemeData.colorTextPrimary
//        label.font = .systemFont(ofSize: 18, weight: .semibold)
//        return label
//    }()
    
//    let motivationalQuoteLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.textColor = AppThemeData.colorTextBlack
//        label.font = .systemFont(ofSize: 16, weight: .regular)
//        label.numberOfLines = 0
//        return label
//    }()
    
    let profileSummaryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    let heightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    let bmiLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    let bmiStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    let fitnessGoalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func configure(userModel: UserModel) {
        imageView.image = UIImage(named: "iOFitness")
        titleLabel.text = "iOFitness"
        let currentTimePeriod = GreetingHelper.getCurrentTimePeriod()
        let currentMood = GreetingHelper.getCurrentMood()
        greetingsLabel.text = "\(currentTimePeriod), \(userModel.firstName)!"
        profileSummaryLabel.text = "Profile Summary"
        heightLabel.text = "Height: \(userModel.height)"
        weightLabel.text = "Weight: \(userModel.weight)"
        let bmiValue = BMIHelper().calculateBMI(height: userModel.height, weight: userModel.weight)
        let bmiStatus = "Not Defined";
        bmiLabel.text = "Current BMI: \(bmiValue)"
        bmiLabel.text = "BMI Status: \(bmiStatus)"
        fitnessGoalLabel.text = "Fitness Goal: \(userModel.fitnessGoal)"
    }
    
    // Update BMI
    func updateBMIValue(height: Double, weight: Double) {
        let bmiValue = BMIHelper().calculateBMI(height: height, weight: weight)
        let bmiStatus = BMIHelper().getBMIStatus(bmiValue: bmiValue)
        bmiLabel.text = "Current BMI: \(bmiValue)"
        bmiStatusLabel.text = "BMI Status: \(bmiStatus)"
    }

    private func setupUI() {
        backgroundColor = .white
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(greetingsLabel)
        contentView.addSubview(profileSummaryLabel)
        contentView.addSubview(heightLabel)
        contentView.addSubview(weightLabel)
        contentView.addSubview(bmiLabel)
        contentView.addSubview(bmiStatusLabel)
        contentView.addSubview(fitnessGoalLabel)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(fitnessGoalLabel.snp.bottom).offset(16)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(120)
            make.height.equalTo(120)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        greetingsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        profileSummaryLabel.snp.makeConstraints { make in
            make.top.equalTo(greetingsLabel.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        heightLabel.snp.makeConstraints { make in
            make.top.equalTo(profileSummaryLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        weightLabel.snp.makeConstraints { make in
            make.top.equalTo(heightLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        bmiLabel.snp.makeConstraints { make in
            make.top.equalTo(weightLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        bmiStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(bmiLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        fitnessGoalLabel.snp.makeConstraints { make in
            make.top.equalTo(bmiStatusLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
}

