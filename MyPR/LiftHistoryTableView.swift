//
//  LiftHistoryTableView.swift
//  MyPR
//
//  Created by Peter Gelsomino on 9/11/18.
//  Copyright © 2018 PeteGels. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LiftHistoryTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    var lifts = [Lift]()
    var ref = Database.database().reference(withPath: "users")
    var user: User!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lifts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
    }
    
}
