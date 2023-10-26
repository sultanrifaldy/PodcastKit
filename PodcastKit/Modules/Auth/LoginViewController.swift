//
//  LoginViewController.swift
//  PodcastKit
//
//  Created by Sultan Rifaldy on 19/12/22.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var eyeLabel: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        // Do any additional setup after loading the view.
        
        //FIXME: - Remove Later
        showMainViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setUp () {
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.signInButton.isEnabled = false
        
        emailTextField.attributedPlaceholder = NSAttributedString(
        string: "E-mail",
        attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 14, weight: .medium)
        ]
        )
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string:  "Password",
            attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 14, weight: .medium)
            ]
        )
        
        signInButton.layer.cornerRadius = 4
        signInButton.layer.masksToBounds = true
    }
    
    func isEmailValid(email: String?) -> Bool {
        let value = email ?? emailTextField.text ?? ""
        return value.isEmailValid
    }
    
    func isPasswordValid(password: String?) -> Bool {
        let value = password ?? passwordTextField.text ?? ""
        return value.count >= 3
    }
    
    //MARK: - Actions
    @IBAction func eyeButton(_ sender: UIButton) {
    }
    
    @IBAction func signUpButton(_ sender: Any) {
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        showMainViewController()
    }
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
       showRegisterViewController()
    }
}

//MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var isEmailValid = false
        var isPasswordValid = false
        
        let newString = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        if textField == emailTextField {
            isEmailValid = self.isEmailValid(email: newString)
            isPasswordValid = self.isPasswordValid(password: nil)
        } else {
            isPasswordValid = self.isPasswordValid(password: newString)
            isEmailValid = self.isEmailValid(email: nil)
        }
        
        signInButton.isEnabled = isEmailValid && isPasswordValid
        
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}


