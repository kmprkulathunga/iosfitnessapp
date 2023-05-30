//
//  AppAlertDialog.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import UIKit

public class AppAlertDialog {
    public func showErrorAlert(viewController: UIViewController, error: String, message: String) {
        let alertController = UIAlertController(title: error, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        okAction.setValue(AppThemeData.colorPrimary, forKey: "titleTextColor")
        
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}

