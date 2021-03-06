//
//  AppEntryViewController.swift
//  XCUITestKit_Example
//
//  Created by Darren Lai on 7/7/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class AppEntryViewController: UITableViewController {
    @IBOutlet weak var liveResetDetails: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "XCUITestKit Example"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.clearsSelectionOnViewWillAppear = false
        liveResetDetails.textLabel?.text = "gRPC server started on port: -"
        liveResetDetails.detailTextLabel?.text = "-"
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Live reset enabled: \(false)"
        }
        return "Tests"
    }
    
}
