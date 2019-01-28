//
//  SignUpViewController.swift
//  MyPR
//
//  Created by Peter Gelsomino on 9/21/18.
//  Copyright © 2018 PeteGels. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var retypePasswordTextField: UITextField!
    
    var currentUser: User?
    
    //UI Outlets
    @IBOutlet weak var welcomeButtonTextLabel: UILabel!
    @IBOutlet weak var prSubTitleLabel: UILabel!
    @IBOutlet weak var prSubTitleLabel2: UILabel!
    
    @IBOutlet weak var registerButtonTextLabel: UIButton!
    @IBOutlet weak var backToSignInButtonLabel: UIButton!
    
    
    @IBAction func registerButton(_ sender: Any) {
        
        if passwordTextField.text != retypePasswordTextField.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!){ (user, error) in
                if error == nil {
                    guard let _ = user else { return }
                    self.performSegue(withIdentifier: "signUpViaRegisterSegue", sender: self)
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    @IBAction func backToSignInButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTextField.tag = 0
        self.passwordTextField.tag = 1
        self.retypePasswordTextField.tag = 2
        
        self.welcomeButtonTextLabel.textColor = UIColor(hexString: "82D4BB")
        self.prSubTitleLabel.textColor = UIColor(hexString: "F7C59F")
        self.prSubTitleLabel2.textColor = UIColor(hexString: "F7C59F")
        self.registerButtonTextLabel.setTitleColor(UIColor(hexString: "F7C59F"), for: .normal)
        self.backToSignInButtonLabel.setTitleColor(UIColor(hexString: "F7C59F"), for: .normal)
        
        self.emailTextField.keyboardType = UIKeyboardType.emailAddress
        self.passwordTextField.isSecureTextEntry = true
        self.retypePasswordTextField.isSecureTextEntry = true
    
        self.view.backgroundColor = UIColor(hexString: "#2E4057")
        // Do any additional setup after loading the view.
        
        self.hideKeyboardWhenTappedAround() 
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
        if segue.identifier == "signUpViaRegisterSegue" {
            let nav = segue.destination as! UINavigationController
            let svc = nav.topViewController as! DashboardViewController
            svc.user = self.currentUser
        }
    }

}
