//
//  TableViewDataSourceDelegate.swift
//  XCUITestKit_Example
//
//  Created by Darren Lai on 12/26/19.
//  Copyright © 2019 darren.lai. All rights reserved.
//

import UIKit

class TableViewDataSourceDelegate: NSObject, UITableViewDelegate,  UITableViewDataSource {
    func registerCell(with tableView: UITableView) {
        tableView.register(ThirtyDayCell.self, forCellReuseIdentifier: "cellId")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ThirtyDayCell
        cell.backgroundColor = UIColor.white
        cell.dayLabel.text = "Day \(indexPath.row+1) for TableView"
        cell.accessibilityIdentifier = "Cell_Sec\(indexPath.section)_Row\(indexPath.row)"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

