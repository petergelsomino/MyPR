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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lifts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LiftHistoryCell", for: indexPath) as! LiftHistoryTableViewCell
        
        let liftcell = lifts[indexPath.row]
        
        cell.lbsHistoryLabel.text = "\(liftcell.maxLift) LBS"
        cell.dateLiftHistory.text = liftcell.liftDate
//        cell.repsHistoryLabel.text = liftcell.
       
//        cell.liftLabel.text = liftcell.name
//        cell.maxLiftLabel.text = "\(liftcell.maxLift) LBS"
//        cell.liftDate.text = liftcell.liftDate
//
//        // Get the cell to wrap
//        cell.liftLabel.contentMode = .scaleToFill
//        cell.liftLabel.numberOfLines = 0
        
        return cell
    }
    
    func getLiftHistory(emailString: String, liftName: String, liftNamesArray: [String]) {
        for lift in liftNamesArray {
            
            var lft = lift.replacingOccurrences(of: " ", with: "")
            lft = lft.lowercased()
            
            let liftRef = self.ref.child("/\(emailString)/allLifts/\(lft)").queryOrdered(byChild: "liftDate")
            liftRef.observe(.value, with: { snapshot in
                
                var previousLifts: [Lift] = []
                
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot,
                        let lift = Lift(snapshot: snapshot) {
                    }
                }
                self.lifts = previousLifts
                self.tableView.reloadData()
            })
        }
    }
}
