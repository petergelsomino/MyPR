//
//  LoginViewController.swift
//  MyPR
//
//  Created by Peter Gelsomino on 9/21/18.
//  Copyright © 2018 PeteGels. All rights reserved.
//

import UIKit
import FirebaseAuth
import Crashlytics

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var currentUser: User?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginButtonLabel: UIButton!
    @IBOutlet weak var signUpButtonLabel: UIButton!
    
    @IBOutlet weak var subTitleTextOne: UILabel!
    @IBOutlet weak var subTitleText2: UILabel!
    
    @IBAction func loginButton(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error == nil {
                Auth.auth().addStateDidChangeListener { auth, user in
                    guard let user = user else { return }
                    self.currentUser = User(authData: user)
                    self.performSegue(withIdentifier: "loginToHome", sender: self)
                }
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.textColor = UIColor(hexString: "82D4BB")
        self.loginButtonLabel.setTitleColor(UIColor(hexString: "F7C59F"), for: .normal)
        self.signUpButtonLabel.setTitleColor(UIColor(hexString: "F7C59F"), for: .normal)
        self.view.backgroundColor = UIColor(hexString: "#2E4057")
        self.subTitleTextOne.textColor = UIColor(hexString: "F7C59F")
        self.subTitleText2.textColor = UIColor(hexString: "F7C59F")
        
        self.emailTextField.keyboardType = UIKeyboardType.emailAddress
        self.passwordTextField.isSecureTextEntry = true
        self.emailTextField.tag = 0
        self.passwordTextField.tag = 1
       
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        if Auth.auth().currentUser != nil {
            self.currentUser = User(authData: Auth.auth().currentUser!)
            print("PETE: were already signed in")
            
            DispatchQueue.main.async(){
                self.performSegue(withIdentifier: "alreadyLoggedIn", sender: self)
            }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    //MARK: - Controlling the Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "alreadyLoggedIn" || segue.identifier == "loginToHome" {
            let nav = segue.destination as! UINavigationController
            let svc = nav.topViewController as! DashboardTableViewController
            svc.user = self.currentUser
        }
    }

}
