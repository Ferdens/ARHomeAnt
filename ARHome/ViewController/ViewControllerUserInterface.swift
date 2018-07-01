//
//  ViewControllerUserInterface.swift
//  ARHome
//
//  Created by anton Shepetuha on 01.07.2018.
//  Copyright © 2018 Anton. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    
    func setupUI() {
        
        let tableViewContainer = UIView()
        tableViewContainer.translatesAutoresizingMaskIntoConstraints = false
        tableViewContainer.backgroundColor = .white
        self.view.addSubview(tableViewContainer)
        tableViewContainer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableViewContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableViewContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableViewContainerHeightConstraint = tableViewContainer.heightAnchor.constraint(equalToConstant: 20)
        tableViewContainerHeightConstraint.isActive = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = .lightText
        bottomView.addGestureRecognizer(tapGesture)
        tableViewContainer.addSubview(bottomView)
        bottomView.bottomAnchor.constraint(equalTo: tableViewContainer.bottomAnchor).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: tableViewContainer.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: tableViewContainer.trailingAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        bottomViewImageView.translatesAutoresizingMaskIntoConstraints = false
        bottomViewImageView.contentMode = .scaleAspectFit
        bottomViewImageView.backgroundColor = .clear
        bottomViewImageView.image = #imageLiteral(resourceName: "arrow-icon")
        bottomView.addSubview(bottomViewImageView)
        bottomViewImageView.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
        bottomViewImageView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        bottomViewImageView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        bottomViewImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ItemCell.self, forCellReuseIdentifier: itemCellReuseID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        tableViewContainer.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: tableViewContainer.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: tableViewContainer.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: tableViewContainer.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        
        let visualEffect = UIBlurEffect(style: .light)
        
        blurView = UIVisualEffectView(effect: visualEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.alpha = 0
        self.view.addSubview(blurView)
        blurView.topAnchor.constraint(equalTo: tableViewContainer.bottomAnchor).isActive = true
        blurView.leadingAnchor.constraint(equalTo: tableViewContainer.leadingAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: tableViewContainer.trailingAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        leftRotationButton.translatesAutoresizingMaskIntoConstraints = false
        leftRotationButton.setBackgroundImage(#imageLiteral(resourceName: "left-icon"), for: .normal)
        leftRotationButton.addTarget(self, action: #selector(leftRotationButtonAction), for: .touchUpInside)
        leftRotationButton.isHidden = true
        self.view.addSubview(leftRotationButton)
        leftRotationButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        leftRotationButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        leftRotationButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        leftRotationButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        rightRotationButton.translatesAutoresizingMaskIntoConstraints = false
        rightRotationButton.setBackgroundImage(#imageLiteral(resourceName: "right-icon"), for: .normal)
        rightRotationButton.addTarget(self, action: #selector(rightRotationButtonAction), for: .touchUpInside)
        rightRotationButton.isHidden = true
        self.view.addSubview(rightRotationButton)
        rightRotationButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        rightRotationButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        rightRotationButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        rightRotationButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
}
