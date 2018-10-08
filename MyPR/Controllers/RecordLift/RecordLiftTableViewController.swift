//
//  RecordLiftTableViewController.swift
//  MyPR
//
//  Created by Peter Gelsomino on 8/23/18.
//  Copyright © 2018 PeteGels. All rights reserved.
//

import UIKit
import os
import FirebaseDatabase
import FirebaseAuth

class RecordLiftTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK Properties
    var pickerData: [String] = [String]()
    var repsPickerData: [String] = [String]()
    var lift: Lift?
    var user: User!
    
    //MARK Outlets
    @IBOutlet weak var chosenLift: UILabel!
    @IBOutlet weak var poundsSelected: UILabel!
    @IBOutlet weak var dateSelected: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var poundsPicker: UIPickerView!
    @IBOutlet weak var repsPicker: UIPickerView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var repsSelected: UILabel!
    
    //MARK: Actions
    @IBAction func dateChanged(_ sender: Any) {
        let formattedDate = formatDate(datePicker: datePicker)
        dateSelected.text = "\(formattedDate)"
    }
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    // Cancel button is tapped
    @IBAction func unwindToRecordLift(segue:UIStoryboardSegue) {
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chosenLift.text = self.chosenLift.text
        
        datePicker.datePickerMode = .date
        datePicker.date = Date()
        dateSelected.text = "\(datePicker.date)"
        datePicker.isHidden = true
        dateSelected.text = formatDate(datePicker: datePicker)
        
        poundsPicker.isHidden = true
        repsPicker.isHidden = true
        pickerData = poundsPickerData()
        repsPickerData = ["1", "2", "3", "5"]
        
        // Connect data:
        self.poundsPicker.delegate = self
        self.poundsPicker.dataSource = self
        self.poundsPicker.tag = 1
        
        self.repsPicker.delegate = self
        self.repsPicker.dataSource = self
        self.repsPicker.tag = 2
        
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
        }
        
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

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dateSelectedRowNumber = IndexPath(row: 0, section: 0)
        let poundsSelectedRowNumber = IndexPath(row: 3, section: 0)
        let repsSelectedRowNumber = IndexPath(row: 5, section: 0)
        
        if dateSelectedRowNumber == indexPath {
            selectedDatePickerRow(indexPath: indexPath)
        } else if poundsSelectedRowNumber == indexPath {
           selectedPoundsPickerRow(indexPath: indexPath)
        }  else if repsSelectedRowNumber == indexPath {
            selectedRepsPickerRow(indexPath: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let datePickerRow = 1
        let poundsPickerRow = 4
        let repsPickerRow = 6
        
        if indexPath.section == 0 && indexPath.row == datePickerRow {
            return expandDatePickerViewRowHeight()
        } else if indexPath.section == 0 && indexPath.row == poundsPickerRow {
            return expandPoundsPickerViewRowHeight()
        } else if indexPath.section == 0 && indexPath.row == repsPickerRow {
            return expandRepsPickerViewRowHeight()
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let liftChosen = chosenLift.text
        let liftLbs = convertStringToInt(string: poundsSelected.text!)
        let liftDate = dateSelected.text ?? ""
        let reps = convertStringToInt(string: repsSelected.text!)
        let user = self.user.email
        print("PETE: --> \(user)")
        lift = Lift(name: liftChosen!, maxLift: liftLbs, liftDate: liftDate, reps: reps, recordedByUser: user)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1){
            return pickerData.count
        }else{
            return repsPickerData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1){
            return "\(pickerData[row])"
        } else {
            return "\(repsPickerData[row])"
        }
    }
    
    func selectedDatePickerRow(indexPath: IndexPath) {
        datePicker.isHidden = !datePicker.isHidden
        animateRowsWhenTapped(indexPath: indexPath)
    }
    
    func selectedPoundsPickerRow(indexPath: IndexPath) {
        poundsPicker.isHidden = !poundsPicker.isHidden
        animateRowsWhenTapped(indexPath: indexPath)
    }
    
    func selectedRepsPickerRow(indexPath: IndexPath) {
        repsPicker.isHidden = !repsPicker.isHidden
        animateRowsWhenTapped(indexPath: indexPath)
    }
    
    func formatDate(datePicker: UIDatePicker) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: datePicker.date)
    }
    
    func expandDatePickerViewRowHeight() -> CGFloat {
        let height:CGFloat = datePicker.isHidden ? 0.0 : 216.0
        return height
    }
    
    func expandPoundsPickerViewRowHeight() -> CGFloat {
        let height:CGFloat = poundsPicker.isHidden ? 0.0 : 216.0
        return height
    }
    
    func expandRepsPickerViewRowHeight() -> CGFloat {
        let height:CGFloat = repsPicker.isHidden ? 0.0 : 216.0
        return height
    }
    
    func animateRowsWhenTapped(indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.tableView.beginUpdates()
            self.tableView.deselectRow(at: indexPath, animated: true)
            self.tableView.endUpdates()
            print("inside animation")
        })
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            poundsSelected.text = pickerData[row]
            repsSelected.text = repsPickerData[row]
    }

    
    func convertStringToInt(string: String) -> Int {
        return Int(string)!
    }
    
    func poundsPickerData() -> [String] {
        let min = 0
        let max = 500
        let int = 5
        var weightStringArray: [String] = []
        
        for weight in stride(from: min, to: max, by: int) {
           weightStringArray.append(String(weight))
        }
        
        return weightStringArray
    }

}
