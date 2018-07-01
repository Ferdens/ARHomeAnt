//
//  ItemCell.swift
//  ARHome
//
//  Created by anton Shepetuha on 01.07.2018.
//  Copyright © 2018 Anton. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    let itemImageView = UIImageView()
    let itemNameLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .white
        
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.contentMode = .scaleAspectFit
        self.contentView.addSubview(itemImageView)
        itemImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        itemImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        itemImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        itemImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15).isActive = true
        
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemNameLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        self.contentView.addSubview(itemNameLabel)
        itemNameLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10).isActive = true
        itemNameLabel.topAnchor.constraint(equalTo: itemImageView.topAnchor).isActive = true
        itemNameLabel.bottomAnchor.constraint(equalTo: itemImageView.bottomAnchor).isActive = true
        itemNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
