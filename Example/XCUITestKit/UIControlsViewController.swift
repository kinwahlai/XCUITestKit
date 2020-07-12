//
//  ViewController.swift
//  XCUITestKit
//
//  Created by Darren Lai on 12/25/2019.
//  Copyright (c) 2019 Darren Lai. All rights reserved.
//

import UIKit

class ItemPickerDataSourceDelegate: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    let items = ["Seattle", "Portland", "Bend", "San Francisco", "Cupertino", "San Jose"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        items[row]
    }
}

class UIControlsViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailFieldError: UILabel!
    @IBOutlet weak var delayedAppearLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!
    @IBOutlet weak var cityPicker: UIPickerView!
    let pickerData = ItemPickerDataSourceDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "element_screen"
        delayedAppearLabel.isHidden = true
        cityPicker.dataSource = pickerData
        cityPicker.delegate = pickerData
        title = "UI Controls"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let deadlineTime = DispatchTime.now() + .seconds(3)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) { [weak self] in
            self?.delayedAppearLabel.isHidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func showAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "Alert", message: "show this for testing", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func verifyEmail(_ sender: Any) {
        guard let fieldValue = emailTextField.text, fieldValue.contains("@") else {
            emailFieldError.text = "Please enter a valid email"
            emailFieldError.isHidden = false
            return
        }
        emailFieldError.isHidden = true
    }
}

