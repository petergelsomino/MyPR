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
    var user: User!
    
    var liftObjects = LiftObjectsArray()

    private func loadSampleLifts() {
       // let lift1 = Lift(name: "Back Squat", maxLift: 175, liftDate: "5/6/2018", recordedByUser: "plgelsomino@gmail.com")
        
//        lifts += [lift1]
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("inside view did load")
        print("User Here \(self.user.email)")
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
            print("Setting the user in View Did Load")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(self.user.email)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

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
        let emailString = self.user.email.replacingOccurrences(of: ".", with: "-")

        cell.liftLabel.text = liftcell
        getHighestliftValuePerCategory(emailString: emailString, liftName: cell.liftLabel.text!) { (maxLift) -> () in
            if maxLift ==  0 {
                cell.maxLiftLabel.text = "--"
            }
            else {
                cell.maxLiftLabel.text = String(maxLift)
            }
        }
        
        // Get the cell to wrap
        cell.liftLabel.contentMode = .scaleToFill
        cell.liftLabel.numberOfLines = 0

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return liftObjects.liftObjectsArray[section].liftSectionName
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
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
        }
    }
    
    func getHighestliftValuePerCategory(emailString: String, liftName: String, completion: @escaping (Int) -> ()) {
        let group = DispatchGroup()
        group.enter()

        var liftString = liftName.replacingOccurrences(of: " ", with: "")
        liftString = liftString.lowercased()
        
        let liftRef = self.ref.child("/\(emailString)/allLifts/\(liftString)").queryOrdered(byChild: "maxLift")
        var currentMaxLift = 0
        liftRef.observe(.value, with: { snapshot in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let temp = Lift(snapshot: snapshot) {
                    print("Pete in temp snapshot")
                    print("Current maxLift = \(currentMaxLift)")
                    print("Current maxLift = \(temp.maxLift)")
                    if currentMaxLift <= temp.maxLift {
                        currentMaxLift = temp.maxLift
                    }
                }
            }
            completion(currentMaxLift)
        })
    }
}

