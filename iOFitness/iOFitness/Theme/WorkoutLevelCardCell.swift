//
//  WorkoutLevelCardCell.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import UIKit
import SnapKit
import SDWebImage

class WorkoutLevelCardCell: UICollectionViewCell {
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let captionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.borderWidth = 0
        layer.borderColor = UIColor.lightGray.cgColor
        
        addSubview(backgroundImageView)
        addSubview(titleLabel)
        addSubview(captionLabel)
        addSubview(valueLabel)
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.6).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        backgroundImageView.layer.addSublayer(gradientLayer)
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        captionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(captionLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        titleLabel.textColor = .white
        captionLabel.textColor = .white
        valueLabel.textColor = .white
    }
    
    
    func configure(card: CardModel) {
        titleLabel.text = card.title
        captionLabel.text = card.caption
        valueLabel.text = card.value
        
        if let imageUrl = URL(string: card.image) {
            // The URL string is valid, proceed to load the image
            backgroundImageView.sd_setImage(with: imageUrl, completed: nil)
        } else {
            // The URL string is valid, proceed to load the image
            backgroundImageView.sd_setImage(with: URL(string: "https://images.pexels.com/photos/2294361/pexels-photo-2294361.jpeg?auto=compress&cs=tinysrgb&w=1600"), completed: nil)
            
        }
        
    }
    
}

