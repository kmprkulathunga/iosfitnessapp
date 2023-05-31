//
//  AboutExView.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-31.
//

import UIKit
import SnapKit
import YouTubeiOSPlayerHelper

class AboutExView: UIView {
    
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    let muscleGroupLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let repLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let playerView: YTPlayerView = {
        let view = YTPlayerView()
        return view
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        if #available(iOS 16.0, *) {
            let activityIndicatorView = UIActivityIndicatorView(style: .medium)
            activityIndicatorView.hidesWhenStopped = true
            return activityIndicatorView
        } else {
            let activityIndicatorView = UIActivityIndicatorView(style: .gray)
            activityIndicatorView.hidesWhenStopped = true
            return activityIndicatorView
        }
    }()
    
    let addToScheduleButton = AppButton.primaryButton(title: "Add To Schedule")
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func configure(workoutLevelExcersiseModel: WorkoutLevelExcersiseModel, level: String, muscleGroup: String) {
        titleLabel.text = level
        muscleGroupLabel.text = muscleGroup
        descriptionLabel.text = workoutLevelExcersiseModel.description
        repLabel.text = "Rep: \(workoutLevelExcersiseModel.reps)"
        DispatchQueue.global().async { [weak self] in
            self?.startLoading()
            DispatchQueue.main.async {
                self?.playerView.load(withVideoId: workoutLevelExcersiseModel.video)
            }
        }
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(muscleGroupLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(repLabel)
        contentView.addSubview(playerView)
        addSubview(activityIndicatorView)
        contentView.addSubview(addToScheduleButton)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(addToScheduleButton.snp.bottom).offset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        muscleGroupLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(muscleGroupLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        repLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        playerView.snp.makeConstraints { make in
            make.top.equalTo(repLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(200) // Adjust the height as needed
        }
        
        addToScheduleButton.snp.makeConstraints { make in
            make.top.equalTo(playerView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(playerView)
        }
    }
    
    private func startLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicatorView.startAnimating()
        }
    }
    
    private func stopLoading() {
        activityIndicatorView.stopAnimating()
    }
    
}
