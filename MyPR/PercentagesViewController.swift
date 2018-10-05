//
//  PercentagesViewController.swift
//  MyPR
//
//  Created by Peter Gelsomino on 9/12/18.
//  Copyright © 2018 PeteGels. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class PercentagesViewController: UIViewController {
    
    // MARK: Properties
    var repMaxFloat:Float = 0.0
    var ref = Database.database().reference(withPath: "users")
    var user: User!
    var lifts = [Lift]()
    

    @IBOutlet weak var oneRepMax: UILabel!
    @IBOutlet weak var twoRepMax: UILabel!
    @IBOutlet weak var threeRepMax: UILabel!
    @IBOutlet weak var fiveRepMax: UILabel!
    
    @IBOutlet weak var seventyPercentLabel: UILabel!
    @IBOutlet weak var seventyFivePercentageLabel: UILabel!
    @IBOutlet weak var eightyPercentageLabel: UILabel!
    @IBOutlet weak var eightyFivePercentageLabel: UILabel!
    @IBOutlet weak var nintyPercentageLabel: UILabel!
    @IBOutlet weak var nintyFivePercentageLabel: UILabel!
    @IBOutlet weak var oneHundredPercentageLabel: UILabel!
    @IBOutlet weak var oneHundredFivePercentageLabel: UILabel!
    
    @IBOutlet weak var segmentedControlLabel: UISegmentedControl!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    // MARK: Actions
    @IBAction func segmentedControlAction(_ sender: Any) {
        switch segmentedControlLabel.selectedSegmentIndex
        {
        case 0:
            print("First Segment Selected")
            repMaxFloat = Float(oneRepMax.text!)!
            calculatePercentagesBasedOnReps(repMax: repMaxFloat)
            
        case 1:
            print("second Segment Selected")
            repMaxFloat = Float(twoRepMax.text!)!
            calculatePercentagesBasedOnReps(repMax: repMaxFloat)
        case 2:
            print("third Segment Selected")
            repMaxFloat = Float(threeRepMax.text!)!
            calculatePercentagesBasedOnReps(repMax: repMaxFloat)
        case 3:
            print("forth Segment Selected")
            repMaxFloat = Float(fiveRepMax.text!)!
            calculatePercentagesBasedOnReps(repMax: repMaxFloat)
        default:
            break
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("In Percentages View Controller")
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
            let adjusteduser = self.user.email.replacingOccurrences(of: ".", with: "-")
            self.getLiftHistory(emailString: adjusteduser, liftName: "Back Squat")
        }
    
        repMaxFloat = Float(oneRepMax.text!)!
        calculatePercentagesBasedOnReps(repMax: repMaxFloat)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calculatePercentagesBasedOnReps(repMax: Float) {
        seventyPercentLabel.text = String(Int((repMax * 0.7).rounded()))
        seventyFivePercentageLabel.text = String(Int((repMax * 0.75).rounded()))
        eightyPercentageLabel.text = String(Int((repMax * 0.80).rounded()))
        eightyFivePercentageLabel.text = String(Int((repMax * 0.85).rounded()))
        nintyPercentageLabel.text = String(Int((repMax * 0.9).rounded()))
        nintyFivePercentageLabel.text = String(Int((repMax * 0.95).rounded()))
        oneHundredPercentageLabel.text = String(Int((repMax).rounded()))
        oneHundredFivePercentageLabel.text = String(Int((repMax * 1.05).rounded()))
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("in prepare segue")
//        if let vc = segue.destination as? LiftHistoryViewController {
//            vc.lifts = self.lifts
//        }
//    }

    func getLiftHistory(emailString: String, liftName: String) {
        
        var lift = liftName.replacingOccurrences(of: " ", with: "")
        lift = lift.lowercased()
        
        let liftRef = self.ref.child("/\(emailString)/allLifts/\(lift)").queryOrdered(byChild: "liftDate")
        
        liftRef.observe(.value, with: { snapshot in
            
            var previousLifts: [Lift] = []
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let lift = Lift(snapshot: snapshot) {
                    previousLifts.append(lift)
                }
            }
            self.lifts = previousLifts
            
            let liftHistoryVC = self.tabBarController?.viewControllers![1] as! LiftHistoryViewController
            liftHistoryVC.lifts = previousLifts
        })
        
    }
    

}
