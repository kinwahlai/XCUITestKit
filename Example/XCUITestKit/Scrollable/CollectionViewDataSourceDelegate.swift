//
//  CollectionViewDataSourceDelegate.swift
//  XCUITestKit_Example
//
//  Created by Darren Lai on 12/26/19.
//  Copyright © 2019 darren.lai. All rights reserved.
//

import UIKit

class CollectionViewDataSourceDelegate: NSObject, UICollectionViewDelegate,  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var cellColor = true
    var reuseIdentifier = "Cell"

    func registerCell(with collectionView: UICollectionView) {
        collectionView.register(MonthCollectionCell.self, forCellWithReuseIdentifier: "Cell")
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MonthCollectionCell
        cell.monthLabel.text = "\(months[indexPath.row])"
        cell.accessibilityIdentifier = "Cell_Sec\(indexPath.section)_Row\(indexPath.row)"
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 240, height: 160)
    }
}
