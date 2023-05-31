//
//  HomeViewController.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppThemeData.colorBackgroundLight

        let label = UILabel()
        label.text = "HomeViewController"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black

        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}

