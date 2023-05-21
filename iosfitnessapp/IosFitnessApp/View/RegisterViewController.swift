//
//  SignUpViewController.swift
//  FitnessApp
//
//

import UIKit

class RegisterViewController: UIViewController {
    
    var controller = Controller();

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign Up"
        view.backgroundColor = .white
        setupNavigationBar()
        setupViews()
        setupConstraints()
        
    }
    // hide tabBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.layer.zPosition = -1
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.layer.zPosition = 0
    }
    func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.topItem?.title = "Register"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        
        
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = .black
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButton)
        backButton.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        let leftButton = UIBarButtonItem()
        leftButton.customView = backButton
        navigationItem.setLeftBarButton(leftButton, animated: true)
    }
    @objc func backBtnPressed(){
        navigationController?.popViewController(animated: true)
    }
    // MARK: Properties -
    
    let firstnameInput : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Name"
        textField.backgroundColor = .systemGray6
        textField.keyboardType = .emailAddress
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    let passwordInput : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "password"
        textField.textContentType = .password
        textField.isSecureTextEntry.toggle()
        textField.backgroundColor = .systemGray6
        return textField
    }()
    

    let emailInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Email"
        textField.backgroundColor = .systemGray6
        return textField
    }()
    let phoneInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Phone"
        textField.keyboardType = .numberPad
        textField.backgroundColor = .systemGray6
        return textField
    }()
    let ageInput : UITextField = {
        let input = UITextField()
        input.placeholder = "Age"
        input.text = ""
        input.keyboardType = .numberPad
        input.borderStyle = .roundedRect
        input.backgroundColor = .systemGray6
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
    
    let signUpBtn: UIButton = {
        var btn = UIButton()
        btn.setTitle("Register", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 54/2
        btn.addTarget(self, action: #selector(registerClick), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    @objc func registerClick(){
        if(self.emailInput.text!.isEmpty){
            showAlert(title: "Please Enter Email")
            return;
        }

        if(!validateEmail(self.emailInput.text!)){
            showAlert(title: "Invalid Email")
            return;

        }
        if(self.passwordInput.text!.isEmpty){
            showAlert(title: "Please Enter Password")
            return;
        }
        if(!validatePassword(self.passwordInput.text!)){
            showAlert(title: "Password at least 6 characters")
            return;
        }

        self.controller.registerUser(email: self.emailInput.text!, password: self.passwordInput.text!, name: self.firstnameInput.text!, phone: self.phoneInput.text!,age:self.ageInput.text!) {(success) in
            if(success){
                self.showAlert(title: "Success")
            }else{
                self.showAlert(title: "Failed")
            }
        }
    }
    
 
    func setupViews(){
        [inputStack,signUpBtn].forEach {
            view.addSubview($0)
        }
        [firstnameInput,passwordInput,emailInput,phoneInput,ageInput].forEach {
            inputStack.addArrangedSubview($0)
        }
    }
    
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            inputStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            inputStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            inputStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            firstnameInput.heightAnchor.constraint(equalToConstant: 60),
            passwordInput.heightAnchor.constraint(equalToConstant: 60),
            emailInput.heightAnchor.constraint(equalToConstant: 60),
            phoneInput.heightAnchor.constraint(equalToConstant: 60),
            ageInput.heightAnchor.constraint(equalToConstant: 60),
            
            signUpBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            signUpBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            signUpBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            signUpBtn.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
 
    func showAlert(title:String){
        let alertView = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default){_ in
            if(title=="Success"){
                self.navigationController?.popViewController(animated: true)
            }
        }
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
    func validateEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
    func validatePassword(_ password: String) -> Bool {
        if  6 >= password.trimmingCharacters(in: CharacterSet.whitespaces).count {
            return false
        }else{
            return true;
        }
    }
}
