//
//  LoginController.swift
//  gameofChat
//
//  Created by Anthony Ho on 22/10/2018.
//  Copyright © 2018 Anthony Ho. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    var messagesController: MessagesController?
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.359065892, green: 0.5, blue: 0.7607531294, alpha: 1)
        button.setTitle("Register", for: .normal)
        button.layer.cornerRadius = 5
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
    }()
    
    @objc func handleLoginRegister() {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
    }
    
    @objc func handleLogin() {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Form is not valid")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password, completion:
            {(user, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                self.messagesController?.fetchUserandSetupNavBarTitle()
                self.dismiss(animated: true, completion: nil)
        })
    }

    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email address"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gameofthrones_splash")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    
    @objc func handleLoginRegisterChange() {
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        
        //change height of inputContainerView
        inputContainerViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        
        //change height of nameTextField
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
          nameTextFieldHeightAnchor?.isActive = true
        
        //email field
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        //password field
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.3568627451, blue: 0.5921568627, alpha: 1)
    
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        view.addSubview(loginRegisterSegmentedControl)
        setupInputContainerView()
        setupLoginRegisterButton()
        setupProfileImageView()
        setupLoginRegisterSegmentedControl()
    }
    
    func setupLoginRegisterSegmentedControl() {
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    var inputContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    
    func setupInputContainerView() {
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputContainerViewHeightAnchor?.isActive = true
        
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparatorView)
        
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        
        inputsContainerView.addSubview(passwordTextField)
        
        
        //nametextField

        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true

        nameTextField.widthAnchor.constraint(equalTo:inputsContainerView.widthAnchor).isActive = true
        
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo:inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true
     
        //nametext seperator
        
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        
        nameSeparatorView.widthAnchor.constraint(equalTo:inputsContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //emailtextField
        
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        
        emailTextField.widthAnchor.constraint(equalTo:inputsContainerView.widthAnchor).isActive = true
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo:inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        //emailtext seperator
        
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        
        emailSeparatorView.widthAnchor.constraint(equalTo:inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //passwordtextField
        
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        
        passwordTextField.widthAnchor.constraint(equalTo:inputsContainerView.widthAnchor).isActive = true
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo:inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
    
    }
    
    func setupLoginRegisterButton() {
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
          loginRegisterButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    func setupProfileImageView() {
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -12).isActive = true

        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
