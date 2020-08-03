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
    @IBOutlet weak var configView: UILabel!

    private let bag = CollectionBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        bag.addCancellable(
            LiveResetHost.shared.$currentSessionData.observe(with: { [weak self] value in
                guard let self = self else { fatalError("missing self") }
                DispatchQueue.main.async {
                    print(value.debugDescription)
                    self.configView.text = value.debugDescription
                }

            })
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
