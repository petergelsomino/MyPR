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
    var liftName = ""
    var liftObjects = LiftObjectsArray()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose Lift"
        self.tableView.backgroundColor = UIColor(hexString: "#2E4057")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return liftObjects.liftObjectsArray.count

    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liftObjects.liftObjectsArray[section].liftSectionObjects.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return liftObjects.liftObjectsArray[section].liftSectionName

    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = UIColor(hexString: "#2E4057")
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = UIColor(hexString: "#F7C59F")
            headerView.backgroundColor = UIColor(hexString: "#2E4057")
            if let textlabel = headerView.textLabel {
                textlabel.font = UIFont(name: "Copperplate-Bold", size: 25)
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordLiftCell", for: indexPath)
        
        cell.textLabel?.text = liftObjects.liftObjectsArray[indexPath.section].liftSectionObjects[indexPath.row]
        
        cell.textLabel?.textColor = UIColor(hexString: "#F7C59F")
        cell.backgroundColor = UIColor(hexString: "#2E4057")
        cell.textLabel?.font = UIFont(name:"Copperplate", size: 20.0)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        liftName = liftObjects.liftObjectsArray[indexPath.section].liftSectionObjects[indexPath.row]
        performSegue(withIdentifier: "unwindToRecordLift", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToRecordLift" {
            let vc = segue.destination as! RecordLiftTableViewController
            vc.chosenLift.text = liftName
        }
    }
    
}
