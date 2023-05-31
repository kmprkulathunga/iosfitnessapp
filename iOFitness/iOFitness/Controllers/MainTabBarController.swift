//
//  MainTabBarController.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//


import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create instances of the view controllers for each tab
        let home = HomeViewController()
        let workouts = WorkoutsViewController()
        let profile = ProfileViewController()
        
        // Set the view controllers for each tab
        self.setViewControllers([home, workouts, profile], animated: true)
        
        // Resize images
        func resizeImage(named name: String, to size: CGSize) -> UIImage? {
            guard let originalImage = UIImage(named: name) else { return nil }
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            originalImage.draw(in: CGRect(origin: .zero, size: size))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return resizedImage?.withRenderingMode(.alwaysOriginal)
        }

        // Customize the tab bar item for each tab
        let homeImageSize = CGSize(width: 24, height: 24)
        let workoutsImageSize = CGSize(width: 24, height: 24)
        let profileImageSize = CGSize(width: 24, height: 24)

        home.tabBarItem = UITabBarItem(title: "Home", image: resizeImage(named: "home_u", to: homeImageSize), selectedImage: resizeImage(named: "home_s", to: homeImageSize))
        workouts.tabBarItem = UITabBarItem(title: "Workouts", image: resizeImage(named: "workouts_u", to: workoutsImageSize), selectedImage: resizeImage(named: "workouts_s", to: workoutsImageSize))
        profile.tabBarItem = UITabBarItem(title: "Profile", image: resizeImage(named: "profile_u", to: profileImageSize), selectedImage: resizeImage(named: "profile_s", to: profileImageSize))
        
        // Customize the appearance of the tab bar
        let selectedColor = AppThemeData.colorIconSelected
        let unselectedColor = AppThemeData.colorIconUnselected
        
        UITabBar.appearance().tintColor = selectedColor
        UITabBar.appearance().unselectedItemTintColor = unselectedColor
        UITabBar.appearance().backgroundColor = AppThemeData.colorBackgroundLight
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular)]
        UITabBarItem.appearance().setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
    }
    
}

