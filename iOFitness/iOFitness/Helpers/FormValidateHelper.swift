//
//  FormValidateHelper.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import UIKit

class FormValidateHelper {
    
    func validateEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func validateLogIn(viewController: UIViewController, authModel: AuthModel) -> Bool {
        
        if authModel.email.isEmpty && authModel.password.isEmpty {
            AppAlertDialog().showErrorAlert(viewController: viewController, error: "All Fields Required", message: "Please fill in all the required fields.")
            return false
        }
        
        if authModel.email.isEmpty {
            AppAlertDialog().showErrorAlert(viewController: viewController, error: "Email Required", message: "Please fill in your email.")
            return false
        }
        
        if !validateEmail(email: authModel.email) {
            AppAlertDialog().showErrorAlert(viewController: viewController, error: "Invalid Email", message: "Please enter a valid email address.")
            return false
        }
        
        if authModel.password.isEmpty {
            AppAlertDialog().showErrorAlert(viewController: viewController, error: "Password Required", message: "Please fill in your password")
            return false
        }
        
        return true
    }
    
    func validateSignUp(viewController: UIViewController, userAccountModel: UserAccountModel, confirmPassword:String) -> Bool {

        if userAccountModel.firstName.isEmpty && userAccountModel.lastName.isEmpty && userAccountModel.email.isEmpty && userAccountModel.password.isEmpty && confirmPassword.isEmpty {
            AppAlertDialog().showErrorAlert(viewController: viewController, error: "All Fields Required", message: "Please fill in all the required fields.")
            return false
        }

        if userAccountModel.firstName.isEmpty {
            AppAlertDialog().showErrorAlert(viewController: viewController, error: "First Name Required", message: "Please fill in your first name.")
            return false
        }

        if userAccountModel.lastName.isEmpty {
            AppAlertDialog().showErrorAlert(viewController: viewController, error: "Last Name Required", message: "Please fill in your last name.")
            return false
        }

        if userAccountModel.email.isEmpty {
            AppAlertDialog().showErrorAlert(viewController: viewController, error: "Email Required", message: "Please fill in your email.")
            return false
        }

        if !validateEmail(email: userAccountModel.email) {
            AppAlertDialog().showErrorAlert(viewController: viewController, error: "Invalid Email", message: "Please enter a valid email address.")
            return false
        }

        if userAccountModel.password.isEmpty {
            AppAlertDialog().showErrorAlert(viewController: viewController, error: "Password Required", message: "Please fill in your password.")
            return false
        }

        if userAccountModel.password.count < 8 {
            AppAlertDialog().showErrorAlert(viewController: viewController, error: "Invalid Password", message: "Password should be at least \(8) characters long.")
            return false
        }

        if confirmPassword.isEmpty {
            AppAlertDialog().showErrorAlert(viewController: viewController, error: "Confirm Password Required", message: "Please fill in your confirm password")
            return false
        }

        if userAccountModel.password != confirmPassword {
            AppAlertDialog().showErrorAlert(viewController: viewController, error: "Passwords Do Not Match", message: "Password and Confirm Password do not match.")
            return false
        }

        return true
    }
}

