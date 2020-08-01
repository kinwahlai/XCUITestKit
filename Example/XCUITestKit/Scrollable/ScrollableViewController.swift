//
//  ScrollableViewController.swift
//  XCUITestKit_Example
//
//  Created by Darren Lai on 12/26/19.
//  Copyright © 2019 darren.lai. All rights reserved.
//

import UIKit

class ScrollableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    // swiftlint:disable:next weak_delegate
    let tableviewSourceDelegate = TableViewDataSourceDelegate()
    // swiftlint:disable:next weak_delegate
    let collectionviewSourceDelegate = CollectionViewDataSourceDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Hello Scrollable"
        tableviewSourceDelegate.registerCell(with: tableView)
        tableView.delegate = tableviewSourceDelegate
        tableView.dataSource = tableviewSourceDelegate
        tableView.accessibilityIdentifier = "tableview"
        
        collectionviewSourceDelegate.registerCell(with: collectionView)
        collectionView.delegate = collectionviewSourceDelegate
        collectionView.dataSource = collectionviewSourceDelegate
        collectionView.accessibilityIdentifier = "collectionview"
    }
}
