//
//  RemoteConfigViewController.swift
//  XCUITestKit_Example
//
//  Created by Darren Lai on 7/31/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import XCUITestLiveReset

class RemoteConfigViewController: UIViewController {
    @IBOutlet weak var remoteConfigReceived: UILabel!
    @IBOutlet weak var configView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView.text = "aaa"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
