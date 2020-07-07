//
//  MonthCollectionCell.swift
//  XCUITestKit_Example
//
//  Created by Darren Lai on 12/26/19.
//  Copyright © 2019 darren.lai. All rights reserved.
//

import UIKit

class MonthCollectionCell: UICollectionViewCell {
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBlue
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "January"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(cellView)
        cellView.addSubview(monthLabel)
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
        
        monthLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        monthLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        monthLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        monthLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20).isActive = true
    }
}
