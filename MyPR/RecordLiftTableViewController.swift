//
//  RecordLiftTableViewController.swift
//  MyPR
//
//  Created by Peter Gelsomino on 8/23/18.
//  Copyright © 2018 PeteGels. All rights reserved.
//

import UIKit
import os

class RecordLiftTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerData: [String] = [String]()
    var lift: Lift?
    
    //MARK Properties
    @IBOutlet weak var chosenLift: UILabel!
    @IBOutlet weak var poundsSelected: UILabel!
    @IBOutlet weak var dateSelected: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var poundsPicker: UIPickerView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chosenLift.text = self.chosenLift.text
        
        datePicker.datePickerMode = .date
        datePicker.date = Date()
        dateSelected.text = "\(datePicker.date)"
        datePicker.isHidden = true
        dateSelected.text = formatDate(datePicker: datePicker)
        
        poundsPicker.isHidden = true
        pickerData = ["200", "300", "400", "500"]

        // Connect data:
        self.poundsPicker.delegate = self
        self.poundsPicker.dataSource = self
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
        return 5
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dateSelectedRowNumber = IndexPath(row: 0, section: 0)
        let poundsSelectedRowNumber = IndexPath(row: 3, section: 0)
        
        if dateSelectedRowNumber == indexPath {
            selectedDatePickerRow(indexPath: indexPath)
        } else if poundsSelectedRowNumber == indexPath {
           selectedPoundsPickerRow(indexPath: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let datePickerRow = 1
        let poundsPickerRow = 5
        
        if indexPath.section == 0 && indexPath.row == datePickerRow {
            return expandDatePickerViewRowHeight()
        } else if indexPath.section == 0 && indexPath.row == poundsPickerRow {
            return expandPoundsPickerViewRowHeight()
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
        
        let liftDate = dateSelected.text ?? ""
        let liftChosen = chosenLift.text
        let liftLbs = convertStringToInt(string: poundsSelected.text!)
        let liftImage = UIImage(named: "backSquat")
        
        lift = Lift(name: liftChosen!, maxLift: liftLbs, liftImage: liftImage!, liftDate: liftDate)!
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return pickerData.count
    }
    
    
    func selectedDatePickerRow(indexPath: IndexPath) {
        datePicker.isHidden = !datePicker.isHidden
        animateRowsWhenTapped(indexPath: indexPath)
    }
    
    func selectedPoundsPickerRow(indexPath: IndexPath) {
        poundsPicker.isHidden = !poundsPicker.isHidden
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
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func animateRowsWhenTapped(indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.tableView.beginUpdates()
            self.tableView.deselectRow(at: indexPath, animated: true)
            self.tableView.endUpdates()
            print("inside animation")
        })
    }
    
    private func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        poundsSelected.text = pickerData[row]
    }

    
    func convertStringToInt(string: String) -> Int {
        return Int(string)!
    }

}
