//
//  LoginViewController.swift
//  FireBaseChatApp
//
//  Created by Alvin  on 24/12/2022.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var loginButton: HealPrimaryButton!
    
    @IBOutlet weak var registerButton: HealPrimaryButton!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var emailTextView: HealPlainTextFieldContainer!
    @IBOutlet weak var passwordTextView: HealPlainTextFieldContainer!
    
    override func setupUI() {
        super.setupUI()
        
        imageView.image = UIImage(named: "ChatIcon")
        imageView.contentMode = .scaleAspectFill
        
        welcomeLabel.text = "Welcome To Chat App"
        welcomeLabel.numberOfLines = 0
        welcomeLabel.font = .museoSans700(ofSize: 29)
        
        emailLabel.text = "Email"
        emailLabel.font = .museoSans300(ofSize: 19)
        emailLabel.textColor = .secondaryText
        
        passwordLabel.text = "Password"
        passwordLabel.font = .museoSans300(ofSize: 19)
        passwordLabel.textColor = .secondaryText
        
        emailTextView.configureTextFieldAttributes(.email)
        emailTextView.addAttributes(placeholder: "Email")
        
        passwordTextView.configureTextFieldAttributes(.password)
        passwordTextView.addAttributes(placeholder: "Password")
        
        loginButton.buttonStyle = .normal
        
        registerButton.buttonStyle = .plain
        registerButton.setTitle("If You Don't have Account, Register Here", for: .normal)
        
        registerButton.addTarget(self, action: #selector(handleRegisterAction), for: .touchUpInside)
        
    }
    
    @objc func handleRegisterAction() {
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
