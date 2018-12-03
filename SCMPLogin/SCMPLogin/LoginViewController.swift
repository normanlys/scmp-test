//
//  ViewController.swift
//  SCMPLogin
//
//  Created by Norman Lim on 3/12/2018.
//  Copyright © 2018 Norman Lim. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var token: String = ""
    var isLoading = false

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func login(_ sender: Any) {
        guard let email = emailTextField.text, email != "" else {
            showAlert(title: "Email", message: "Please enter your email", handler: {self.emailTextField.becomeFirstResponder()})
            return
        }
        guard let password = passwordTextField.text,
            isValidPassword(password) else {
            showAlert(title: "Password", message: "Invalid password", handler: {self.passwordTextField.becomeFirstResponder()})
            return
        }

        // login API
        _ = startLoading()
        guard let response = API().login(email, password) else { // need to await value
            dismiss(animated: true, completion: {
                self.showAlert(title: "Error", message: "Login unsuccessful")
            })
            return
        }
        token = response
        performSegue(withIdentifier: "LoginSegue", sender: nil)
        return
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        emailTextField.becomeFirstResponder()
        passwordTextField.isSecureTextEntry = true
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginSegue" {
            if let HomeViewController = segue.destination as? HomeViewController {
                HomeViewController.token = token
            }
        }
    }

    func showAlert(title: String?, message: String?, handler: @escaping () -> Void = {return}) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            handler()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        return (6...8).contains(password.count) && password.isAlphanumeric()
    }
    
    func startLoading() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        return alert
    }
    
    func stopLoading() {
        
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
            login(self)
        }
        
        return false
    }
}
