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
    var liftObjectsArray = [LiftObjects]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        liftObjectsArray = [
            LiftObjects(liftSectionName: "Squat", liftSectionObjects: ["Back Squat", "Front Squat", "Hack Squat"]),
            LiftObjects(liftSectionName: "Clean", liftSectionObjects: ["Clean", "Full Power Clean", "Hang Power Clean", "Power Clean"]),
            LiftObjects(liftSectionName: "Snatch", liftSectionObjects: ["Muscle Snatch", "Full Power Snatch", "Hang Power Snatch"])
        ]
        
        
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
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
