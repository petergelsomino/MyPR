//
//  PercentagesViewController.swift
//  MyPR
//
//  Created by Peter Gelsomino on 9/12/18.
//  Copyright © 2018 PeteGels. All rights reserved.
//

import UIKit

class PercentagesViewController: UIViewController {

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
    
    var repMaxFloat:Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

}
