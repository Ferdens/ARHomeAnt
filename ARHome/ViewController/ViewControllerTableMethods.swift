//
//  ViewControllerTableMethods.swift
//  ARHome
//
//  Created by anton Shepetuha on 01.07.2018.
//  Copyright © 2018 Anton. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: itemCellReuseID, for: indexPath) as! ItemCell
        let item = items[indexPath.row]
        cell.itemNameLabel.text = item.itemName.capitalized
        cell.itemImageView.image = item.itemIcon
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        if let node = item.itemNode {
            self.chosenNode = node
        }
        self.closeItemsList()
    }
    
}
