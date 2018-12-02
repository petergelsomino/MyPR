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

class LoginViewController: UIViewController {
    
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
            if error == nil{
                Auth.auth().addStateDidChangeListener { auth, user in
                    guard let user = user else { return }
                    self.currentUser = User(authData: user)
                    self.performSegue(withIdentifier: "loginToHome", sender: self)
                }
            }
            else{
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
        
        if Auth.auth().currentUser != nil {
            self.currentUser = User(authData: Auth.auth().currentUser!)
            print("PETE: were already signed in")
            
            DispatchQueue.main.async(){
                self.performSegue(withIdentifier: "alreadyLoggedIn", sender: self)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("In prepare segue Login to Dashboard")
        if segue.identifier == "alreadyLoggedIn" || segue.identifier == "loginToHome" {
            let nav = segue.destination as! UINavigationController
            let svc = nav.topViewController as! DashboardTableViewController
            svc.user = self.currentUser
        }
    }
 

}
