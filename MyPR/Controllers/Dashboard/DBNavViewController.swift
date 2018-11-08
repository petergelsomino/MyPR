//
//  DBNavViewController.swift
//  MyPR
//
//  Created by Peter Gelsomino on 11/7/18.
//  Copyright © 2018 PeteGels. All rights reserved.
//

import UIKit

class DBNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.barTintColor = UIColor(hexString: "#82D4BB")
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(hexString: "#2E4057"), NSAttributedStringKey.font: UIFont(name: "Copperplate-Bold", size: 40)!]
//        [titleLabelView setAdjustsFontSizeToFitWidth:YES];
    }
    
}
