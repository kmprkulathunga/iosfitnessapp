//
//  ProfileViewController.swift
//  GymApp
//
//

import UIKit
class ProfileViewController: UIViewController {
    
    var controller = Controller();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        
        self.controller.getCurLoginUser{ [self](user,i) -> Void in
            print(user)
            if(i==1){
                firstnameInput.text = user.name
                phoneInput.text = user.phone
                emailInput.text = user.email
                ageInput.text = user.age
            }
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.tabBarController?.tabBarItem.title = "Profile"
//    }

    let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    let firstnameInput: UITextField = {
        let input = UITextField()
        input.placeholder = "Name"
        input.text = ""
        input.isEnabled = false
        input.translatesAutoresizingMaskIntoConstraints = false
        input.leftViewMode = .always
        return input
    }()
    let emailLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email"
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    let emailInput: UITextField = {
        let input = UITextField()
        input.placeholder = "E-mail"
        input.text = ""
        input.isEnabled = false
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    let phoneLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Phone number"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    let phoneInput: UITextField = {
        let input = UITextField()
        input.placeholder = "Phone number"
        input.text = ""
        input.isEnabled = false
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    let ageLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Age"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    let ageInput: UITextField = {
        let input = UITextField()
        input.placeholder = "Age"
        input.text = ""
        input.isEnabled = false
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    
    let inputStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10.0
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    
    let logoutBtn: UIButton = {
        var btn = UIButton()
        btn.setTitle("Log out", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 54/2
        btn.addTarget(self, action: #selector(ougOutClick), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func ougOutClick() {
        
        self.controller.signOut()
        let homeview = UINavigationController(rootViewController: LoginViewController())
        homeview.tabBarItem.image = UIImage(systemName: "house")
        homeview.title = "HOME"
        
        let loginview = UINavigationController(rootViewController: LoginViewController())
        loginview.tabBarItem.image = UIImage(systemName: "person")
        loginview.title = "LOGIN"
        
        self.tabBarController?.selectedIndex = 0;
        self.tabBarController?.tabBar.tintColor = .label
        self.tabBarController?.viewControllers = [homeview,loginview];
    }
    
    func setupViews(){
        [inputStack,logoutBtn].forEach {
            view.addSubview($0)
        }
        [nameLabel,firstnameInput,emailLabel,emailInput,phoneLabel,phoneInput,ageLabel,ageInput].forEach {
            inputStack.addArrangedSubview($0)
        }
    }
    
    
    
    func setupConstraints(){
        
        
        NSLayoutConstraint.activate([
            
            inputStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            inputStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            inputStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            nameLabel.heightAnchor.constraint(equalToConstant: 25),
            firstnameInput.heightAnchor.constraint(equalToConstant: 40),
            emailLabel.heightAnchor.constraint(equalToConstant: 25),
            emailInput.heightAnchor.constraint(equalToConstant: 40),
            phoneLabel.heightAnchor.constraint(equalToConstant: 25),
            phoneInput.heightAnchor.constraint(equalToConstant: 40),
            ageLabel.heightAnchor.constraint(equalToConstant: 25),
            ageInput.heightAnchor.constraint(equalToConstant: 40),
            
            logoutBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            logoutBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            logoutBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            logoutBtn.heightAnchor.constraint(equalToConstant: 56),
            
        ])
    }
    
}
