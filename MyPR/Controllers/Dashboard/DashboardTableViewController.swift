//
//  DashboardTableViewController.swift
//  MyPR
//
//  Created by Peter Gelsomino on 8/23/18.
//  Copyright © 2018 PeteGels. All rights reserved.
//

import UIKit
import os.log
import FirebaseDatabase
import FirebaseAuth
import Firebase

class DashboardTableViewController: UITableViewController {
    
    var lifts = [Lift]()
    var liftTitle = ""
    var ref = Database.database().reference(withPath: "users")
    var user: User?
    
    var liftObjects = LiftObjectsArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor(hexString: "#2E4057")
            
        print("inside view did load")
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadView), name: NSNotification.Name(rawValue: "load"), object: nil)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.backgroundColor = UIColor(hexString: "#2E4057")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.backgroundColor = UIColor(hexString: "#2E4057")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return liftObjects.liftObjectsArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return liftObjects.liftObjectsArray[section].liftSectionObjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("inside cellForRowAt")
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardTableViewCell", for: indexPath) as! DashboardTableViewCell
        let liftcell = liftObjects.liftObjectsArray[indexPath.section].liftSectionObjects[indexPath.row]
       
        cell.liftLabel.contentMode = .scaleToFill
        cell.liftLabel.numberOfLines = 0
        cell.backgroundColor = UIColor(hexString: "#2E4057")
        cell.liftLabel.textColor = UIColor(hexString: "#F7C59F")
        cell.maxLiftLabel.textColor = UIColor(hexString: "#F7C59F")
        
        cell.liftLabel.text = liftcell
        cell.selectionStyle = .none
        
        guard (self.user?.email) != nil else {
            cell.maxLiftLabel.text = "--"
            return cell
        }
        
        let emailString = self.user?.email.replacingOccurrences(of: ".", with: "-")
        
        getHighestliftValuePerCategory(emailString: emailString!, liftName: cell.liftLabel.text!) { (maxLift) -> () in
            if maxLift ==  0 {
                cell.maxLiftLabel.text = "--"
            }
            else {
                cell.maxLiftLabel.text = String(maxLift)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return liftObjects.liftObjectsArray[section].liftSectionName
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        liftTitle = liftObjects.liftObjectsArray[indexPath.section].liftSectionObjects[indexPath.row]
        performSegue(withIdentifier: "dashToPercentage", sender: self)
    }

    
    // Send title information to percentages view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("In prepare segue Dashboard to Percentages")
        if segue.identifier == "dashToPercentage" {
            let vc = segue.destination as! LiftTabBarViewController
            vc.title = liftTitle

            let pvc = vc.childViewControllers[0] as! PercentagesViewController
            pvc.titleName = liftTitle
            
            let lhvc = vc.childViewControllers[1] as! LiftHistoryViewController
            lhvc.titleName = liftTitle
        }
    }
    
    func getHighestliftValuePerCategory(emailString: String, liftName: String, completion: @escaping (Int) -> ()) {

        var liftString = liftName.replacingOccurrences(of: " ", with: "")
        liftString = liftString.lowercased()
        
        let liftRef = self.ref.child("/\(emailString)/allLifts/\(liftString)").queryOrdered(byChild: "maxLift")
        var currentMaxLift = 0
        liftRef.observe(.value, with: { snapshot in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let temp = Lift(snapshot: snapshot) {
                    if currentMaxLift <= temp.maxLift {
                        currentMaxLift = temp.maxLift
                    }
                }
            }
            completion(currentMaxLift)
        })
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = UIColor(hexString: "#F7C59F")
            if let textlabel = headerView.textLabel {
                textlabel.font = UIFont(name: "Copperplate-Bold", size: 20)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 53
    }
    
    @IBAction func unwindToDashboardLiftList(sender: UIStoryboardSegue) {
          tableView.reloadData()
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any) {

            let alert = UIAlertController(title: "Are you sure you want to logout?", message: nil, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                if Auth.auth().currentUser != nil {
                    do {
                        try Auth.auth().signOut()
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
                        self.present(vc, animated: true, completion: nil)
                        
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
    }
    
    func loadList(notification: NSNotification){
        self.tableView.reloadData()
    }
}

