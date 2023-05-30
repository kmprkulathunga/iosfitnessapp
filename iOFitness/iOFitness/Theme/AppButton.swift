//
//  AppButton.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import UIKit

public class AppButton {
    public static func primaryButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(AppThemeData.colorTextWhite, for: .normal)
        button.backgroundColor = AppThemeData.colorPrimary
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = AppThemeData.cornerRadiusButton
        return button
    }
    
    public static func secondaryButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(AppThemeData.colorTextWhite, for: .normal)
        button.backgroundColor = AppThemeData.colorSecondaryBlack
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = AppThemeData.cornerRadiusButton
        return button
    }
    
    public static func textButton(text: String, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.isUserInteractionEnabled = true
        return label
    }
}
