//
//  LiftHistoryViewController.swift
//  MyPR
//
//  Created by Peter Gelsomino on 9/11/18.
//  Copyright © 2018 PeteGels. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class LiftHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var lifts = [Lift]()
    var ref = Database.database().reference(withPath: "users")
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("In History View Controller")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
            print("End of Auth")
        }
        print("Lift History End of View Did Load")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("In Lift History Table View numberOfRowsInSection")
        print(lifts.count)
        return lifts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("In Lift History Table View cellForRowAt")
        let cell = tableView.dequeueReusableCell(withIdentifier: "LiftHistoryCell", for: indexPath) as! LiftHistoryTableViewCell
        
        let liftcell = lifts[indexPath.row]
        
        cell.lbsHistoryLabel.text = "\(liftcell.maxLift)"
        cell.dateLiftHistory.text = liftcell.liftDate
        cell.repsHistoryLabel.text = "\(liftcell.reps)"
        
        return cell
    }
    
}
