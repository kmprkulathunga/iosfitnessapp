//
//  AboutWorkoutView.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-31.
//

import UIKit
import SnapKit

class AboutWorkoutView: UIView {
    
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
    
    let aboutLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppThemeData.colorTextLightGray
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    var workoutCards: [CardModel] = []
    var collectionView = AppCollectionViews.workoutCardCollection(registerClass: WorkoutCardCell.self, cellIdentifier: "WorkoutCardCell")
    var collectionViewHeight = 20
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupCollectionViews()
    }
    
    weak var selectionDelegate: WorkoutSelectionDelegate?
    private func setupCollectionViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configure(cardModel: CardModel) {
        titleLabel.text = cardModel.title
        aboutLabel.text = cardModel.caption + " - " + cardModel.value
    }

    
    private func setupUI() {
        backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(aboutLabel)
        contentView.addSubview(collectionView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(collectionView.snp.bottom).offset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        aboutLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(aboutLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(collectionViewHeight)
        }
    }
}
