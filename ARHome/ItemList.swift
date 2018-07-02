//
//  ItemList.swift
//  ARHome
//
//  Created by anton Shepetuha on 01.07.2018.
//  Copyright © 2018 Anton. All rights reserved.
//

import Foundation
import SceneKit

enum SceneItemType: String {
    
    case dae = "dae"
    case scn = "scn"
}

class Item: NSObject {
    
    var itemName  = String()
    var itemIcon : UIImage?
    private var itemTypeName: SceneItemType
    
    lazy var itemNode = { () -> SCNNode? in
        guard let scene = SCNScene(named: "art.scnassets/\(self.itemName.capitalized)/\(self.itemName).\(self.itemTypeName.rawValue)") else {
            assert(false, "No object with name \(self.itemName).\(self.itemTypeName.rawValue)")
            return nil
        }
        let node = SCNNode()
        let nodeArray = scene.rootNode.childNodes
        
        for childNode in nodeArray {
            node.addChildNode(childNode as SCNNode)
        }
        
        return node
    }()
    
    override init() {
        itemTypeName = .scn
        super.init()
    }
    
    init(itemType: SceneItemType, name: String = "", image: UIImage? = nil) {
        self.itemTypeName = itemType
        self.itemName = name
        self.itemIcon = image
    }
    
}

class ItemList {
    
    static var shared = ItemList()
    
    var itemsList = [Item]()
    
    init() {
        self.itemsList = [Item(itemType: .scn, name: "chair", image: #imageLiteral(resourceName: "chair-icon")), Item(itemType: .dae, name: "cup", image: #imageLiteral(resourceName: "cup-icon")), Item(itemType: .dae, name: "flower", image: #imageLiteral(resourceName: "vase-icon")),Item(itemType: .dae, name: "lamp", image: #imageLiteral(resourceName: "lamp-icon")), Item(itemType: .scn, name: "table", image: #imageLiteral(resourceName: "table-icon"))]
    }
    
}
