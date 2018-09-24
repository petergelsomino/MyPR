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

class DashboardTableViewController: UITableViewController {
    
    var lifts = [Lift]()
    var liftTitle = ""
    let ref = Database.database().reference(withPath: "allLifts")

    
    private func loadSampleLifts() {
        let lift1 = Lift(name: "Back Squat", maxLift: 175, liftDate: "5/6/2018")
        
        lifts += [lift1]
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleLifts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lifts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardTableViewCell", for: indexPath) as! DashboardTableViewCell

        let liftcell = lifts[indexPath.row]

        cell.liftLabel.text = liftcell.name
        cell.maxLiftLabel.text = "\(liftcell.maxLift) LBS"
        cell.liftDate.text = liftcell.liftDate
        
        // Get the cell to wrap
        cell.liftLabel.contentMode = .scaleToFill
        cell.liftLabel.numberOfLines = 0

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    @IBAction func unwindToDashboardLiftList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? RecordLiftTableViewController, let newLift = sourceViewController.lift {
            let newIndexPath = IndexPath(row: lifts.count, section: 0)
            lifts.append(newLift)
            
            let newLiftRef = self.ref.child(newLift.name.lowercased())
            newLiftRef.setValue(newLift.toAnyObject())
            
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        liftTitle = lifts[indexPath.row].name
        performSegue(withIdentifier: "dashToPercentage", sender: self)
    }
    
    // Send title information to percentages view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dashToPercentage" {
            let vc = segue.destination as! LiftTabBarViewController
            vc.title = liftTitle
        }
    }

}
