//
//  RecordLiftTableViewController.swift
//  MyPR
//
//  Created by Peter Gelsomino on 8/23/18.
//  Copyright © 2018 PeteGels. All rights reserved.
//

import UIKit

class ChooseLiftTableViewController: UITableViewController {
    
    // MARK: Variables
    struct LiftObjects {
        var liftSectionName: String
        var liftSectionObjects: [String]
    }

    var liftName = ""
    var liftObjectsArray = [
        LiftObjects(liftSectionName: "Squat", liftSectionObjects: ["Back Squat", "Front Squat", "Hack Squat"]),
        LiftObjects(liftSectionName: "Clean", liftSectionObjects: ["Clean", "Full Power Clean", "Hang Power Clean", "Power Clean"]),
        LiftObjects(liftSectionName: "Snatch", liftSectionObjects: ["Muscle Snatch", "Full Power Snatch", "Hang Power Snatch"])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        liftObjectsArray = [
//            LiftObjects(liftSectionName: "Squat", liftSectionObjects: ["Back Squat", "Front Squat", "Hack Squat"]),
//            LiftObjects(liftSectionName: "Clean", liftSectionObjects: ["Clean", "Full Power Clean", "Hang Power Clean", "Power Clean"]),
//            LiftObjects(liftSectionName: "Snatch", liftSectionObjects: ["Muscle Snatch", "Full Power Snatch", "Hang Power Snatch"])
//        ]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return liftObjectsArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liftObjectsArray[section].liftSectionObjects.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return liftObjectsArray[section].liftSectionName
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordLiftCell", for: indexPath)
        
        cell.textLabel?.text = liftObjectsArray[indexPath.section].liftSectionObjects[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        liftName = liftObjectsArray[indexPath.section].liftSectionObjects[indexPath.row]
        performSegue(withIdentifier: "unwindToRecordLift", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToRecordLift" {
            let vc = segue.destination as! RecordLiftTableViewController
            vc.chosenLift.text = liftName
        }
    }
    
}
