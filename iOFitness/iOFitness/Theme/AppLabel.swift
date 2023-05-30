//
//  AppLabel.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import UIKit

public class AppLabel {
    public static func largeTitle(label: UILabel? = nil) -> UILabel {
        let label = label ?? UILabel()
        label.textAlignment = .left
        label.textColor = .label
       // label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        return label
    }
    
    public static func title1(label: UILabel? = nil) -> UILabel {
        let label = label ?? UILabel()
        label.textAlignment = .left
        label.textColor = .label
//        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return label
    }
    
    public static func title2(label: UILabel? = nil) -> UILabel {
        let label = label ?? UILabel()
        label.textAlignment = .left
        label.textColor = .label
//        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }
    
    public static func title3(label: UILabel? = nil) -> UILabel {
        let label = label ?? UILabel()
        label.textAlignment = .left
        label.textColor = .label
//        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }
    
    public static func headline(label: UILabel? = nil) -> UILabel {
        let label = label ?? UILabel()
        label.textAlignment = .left
        label.textColor = .label
//        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }
    
    public static func headlinePrimaryColor(label: UILabel? = nil) -> UILabel {
        let label = label ?? UILabel()
        label.textAlignment = .left
        label.textColor = AppThemeData.colorTextPrimary
//        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }
    
    public static func subheadline(label: UILabel? = nil) -> UILabel {
        let label = label ?? UILabel()
        label.textAlignment = .left
        label.textColor = .label
//        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }
    
    public static func body(label: UILabel? = nil) -> UILabel {
        let label = label ?? UILabel()
        label.textAlignment = .left
        label.textColor = .label
//        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }
    
    public static func callout(label: UILabel? = nil) -> UILabel {
        let label = label ?? UILabel()
        label.textAlignment = .left
        label.textColor = .label
//        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }
    
    public static func footnote(label: UILabel? = nil) -> UILabel {
        let label = label ?? UILabel()
        label.textAlignment = .left
        label.textColor = .label
//        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }
    
    public static func caption1(label: UILabel? = nil) -> UILabel {
        let label = label ?? UILabel()
        label.textAlignment = .left
        label.textColor = .label
//        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }
    
    public static func caption2(label: UILabel? = nil) -> UILabel {
        let label = label ?? UILabel()
        label.textAlignment = .left
        label.textColor = .label
//        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        return label
    }
}
