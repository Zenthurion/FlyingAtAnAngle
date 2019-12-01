//
//  HighscoreTableViewCell.swift
//  FlyingAtAnAngle
//
//  Created by Markus Jakobsen on 01/12/2019.
//  Copyright © 2019 Markus Jakobsen. All rights reserved.
//

import Foundation
import UIKit

class HighscoreTableViewCell : UITableViewCell {
    let scoreLabel : UILabel = {
        let label = UILabel()
        //label.frame = CGRect(x: 100, y: 0, width: 100, height: 100)
        label.font = UIFont.systemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let nameLabel : UILabel = {
        let label = UILabel()
        //label.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        label.font = UIFont.systemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(nameLabel)
        addSubview(scoreLabel)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-32-[v0]-8-[v1(80)]-8-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": nameLabel, "v1":scoreLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": scoreLabel]))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
