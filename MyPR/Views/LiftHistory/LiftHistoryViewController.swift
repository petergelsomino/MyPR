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
    @IBOutlet weak var headerView: UIView!

    @IBOutlet weak var lbsLabel: UILabel!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var titleName: String?
    
    // MARK: Properties
    var lifts = [Lift]()
    var ref = Database.database().reference(withPath: "users")
    var user: User!
    var emailString: String?
    var liftName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("In History View Controller")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor(hexString: "#2E4057")
        self.tableView.allowsSelection = false
        self.headerView.backgroundColor = UIColor(hexString: "#2E4057")
        
        self.lbsLabel.textColor = UIColor(hexString: "#F7C59F")
        self.repsLabel.textColor = UIColor(hexString: "#F7C59F")
        self.dateLabel.textColor = UIColor(hexString: "#F7C59F")

        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let lift = lifts[indexPath.row]
            lift.ref?.removeValue()
            lifts.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.reloadData()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lifts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LiftHistoryCell", for: indexPath) as! LiftHistoryTableViewCell
        
        let liftcell = lifts[indexPath.row]
        
        cell.lbsHistoryLabel.text = "\(liftcell.maxLift)"
        cell.dateLiftHistory.text = liftcell.liftDate
        cell.repsHistoryLabel.text = "\(liftcell.reps)"
        
        cell.lbsHistoryLabel.textColor = UIColor(hexString: "#F7C59F")
        cell.dateLiftHistory.textColor = UIColor(hexString: "#F7C59F")
        cell.repsHistoryLabel.textColor = UIColor(hexString: "#F7C59F")
        
        cell.backgroundColor = UIColor(hexString: "#2E4057")
        
        return cell
    }
}
