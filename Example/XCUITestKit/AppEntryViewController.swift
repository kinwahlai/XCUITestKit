//
//  AppEntryViewController.swift
//  XCUITestKit_Example
//
//  Created by Darren Lai on 7/7/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import XCUITestLiveReset

class AppEntryViewController: UITableViewController {
    @IBOutlet weak var liveResetDetails: UITableViewCell!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "XCUITestKit Example"
        navigationController?.navigationBar.prefersLargeTitles = true
        clearsSelectionOnViewWillAppear = false
        liveResetDetails.textLabel?.text = "gRPC server started on port: \(LiveResetHost.shared.port)"
        liveResetDetails.detailTextLabel?.text = "\(LiveResetHost.shared.netServiceName)"
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Live reset gRPC configuration"
        }
        return "Tests"
    }

}
