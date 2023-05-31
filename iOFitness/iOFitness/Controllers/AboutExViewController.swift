//
//  AboutExViewController.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-31.
//

import UIKit
import SnapKit

class AboutExViewController: UIViewController {
    private let aboutExView: AboutExView
    private let workoutLevelExcersiseModel: WorkoutLevelExcersiseModel
    private let level: String
    private let muscleGroup: String
    
    init(workoutLevelExcersiseModel: WorkoutLevelExcersiseModel, level: String, muscleGroup: String) {
        self.workoutLevelExcersiseModel = workoutLevelExcersiseModel
        self.level = level
        self.muscleGroup = muscleGroup
        self.aboutExView = AboutExView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        aboutExView.configure(workoutLevelExcersiseModel: workoutLevelExcersiseModel, level: level, muscleGroup: muscleGroup)
        customizeNavigationBarBackButton()
        print("----- AboutExViewController -----")
    }
    
    private func setupUI() {
        view.backgroundColor = AppThemeData.colorBackgroundLight
        title = workoutLevelExcersiseModel.name
        view.addSubview(aboutExView)
        aboutExView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        aboutExView.addToScheduleButton.addTarget(self, action: #selector(addToScheduleButtonTapped), for: .touchUpInside)
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
    
    @objc private func addToScheduleButtonTapped() {
        print("startWorkoutButtonTapped!")
        
//        let nextViewController = AddScheduleViewController(workoutLevelExcersiseModel: self.workoutLevelExcersiseModel, level: self.level, muscleGroup: self.muscleGroup)
//        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

