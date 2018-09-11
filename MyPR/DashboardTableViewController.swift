//
//  DashboardTableViewController.swift
//  MyPR
//
//  Created by Peter Gelsomino on 8/23/18.
//  Copyright © 2018 PeteGels. All rights reserved.
//

import UIKit
import os.log

class DashboardTableViewController: UITableViewController {
    
    var lifts = [Lift]()
    
    private func loadSampleLifts() {
        let photo1 = UIImage(named: "backSquat")
        
        guard let lift1 = Lift(name: "Back Squat", maxLift: 175, liftImage: photo1!, liftDate: "5/6/2018") else {
            fatalError("Unable to instantiate meal1")
        }
        
        lifts += [lift1]
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleLifts()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        cell.liftImage.image = liftcell.liftImage
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
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }

}
