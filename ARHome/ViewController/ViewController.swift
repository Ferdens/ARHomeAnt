//
//  ViewController.swift
//  ARHome
//
//  Created by anton Shepetuha on 01.07.2018.
//  Copyright © 2018 Anton. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

enum AnimationState {
    case closed
    case opened
}

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    var chosenNode: SCNNode? {
        didSet {
           leftRotationButton.isHidden = chosenNode == nil
            rightRotationButton.isHidden = chosenNode == nil
        }
    }
    
    let itemList  = ItemList()
    
    var tableViewContainerHeightConstraint = NSLayoutConstraint()
    var blurView            = UIVisualEffectView()
    let bottomView          = UIView()
    let bottomViewImageView = UIImageView()
    
    let leftRotationButton  = UIButton()
    let rightRotationButton = UIButton()

    let itemCellReuseID = "itemCellReuseID"
    
    var items: [Item] {
        return ItemList.shared.itemsList
    }
    
    var openListHeight: CGFloat {
        return UIScreen.main.bounds.height * 0.3
    }
    
    var currentAnimationState = AnimationState.closed
    var animator: UIViewPropertyAnimator?
    
    // MARK: - Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        let scene = SCNScene()
        sceneView.scene = scene
        
        registerGestures()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    // MARK: - User Actions
    
    @objc func leftRotationButtonAction() {
        guard let node = chosenNode else {return}
        let rotate = SCNAction.rotateBy(x: 0, y: CGFloat(0.01 * Double.pi), z: 0, duration: 0.1)
        node.runAction(rotate)
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    @objc func rightRotationButtonAction() {
        guard let node = chosenNode else {return}
        let rotate = SCNAction.rotateBy(x: 0, y: CGFloat(-0.01 * Double.pi), z: 0, duration: 0.1)
        node.runAction(rotate)
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    @IBAction func cleanSceneAction(_ sender: Any) {
        let childNodes = self.sceneView.scene.rootNode.childNodes
        for node in childNodes {
            node.removeFromParentNode()
        }
    }
    
    @objc func handleScreenTap(gesture: UIGestureRecognizer) {
        let sceneLocation = gesture.view as! ARSCNView
        let touchLocation = gesture.location(in: sceneLocation)
        let hitResults = self.sceneView.hitTest(touchLocation, types: [.existingPlaneUsingExtent, .estimatedHorizontalPlane])
        if hitResults.count > 0 {
            
            guard let hitTestResult = hitResults.first else {return}
            addItem(hitTest: hitTestResult)
        }
    }
    
    // MARK: - ItemsList antimation
    
    @objc func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: self.view)
        switch panGesture.state {
        case .began:
            startPanning()
        case .changed:
            if let animator = self.animator {
                var progress: CGFloat = 0
                switch currentAnimationState {
                case .closed:
                    progress = translation.y / 200
                case .opened:
                    progress = -(translation.y / 200)
                }
                animator.fractionComplete = progress
            }
        case .ended, .cancelled:
            switch currentAnimationState {
            case .closed:
                currentAnimationState = .opened
            case .opened:
                currentAnimationState = .closed
            }
            if let animator = self.animator {
                animator.continueAnimation(withTimingParameters: nil, durationFactor: 1.5)
            }
        default:
            break
        }
    }
    
    func startPanning() {
        var constant: CGFloat = 0
        switch currentAnimationState {
        case .closed:
            constant = openListHeight
        case .opened:
            constant = 20
        }
        self.tableViewContainerHeightConstraint.constant = constant

        self.animator = UIViewPropertyAnimator(duration: 0.3, dampingRatio: 0.8, animations: {
            self.view.layoutIfNeeded()
            self.blurView.alpha = constant == 20 ? 0 : 1
            self.bottomViewImageView.transform = CGAffineTransform(rotationAngle: constant != 20 ? CGFloat(Double.pi) : 0)
        })
        self.animator?.pauseAnimation()
    }
    
    @objc func handleTapGesture(gesture: UITapGestureRecognizer) {
        if tableViewContainerHeightConstraint.constant == 20 {
            openItemsList()
        } else {
            closeItemsList()
        }
    }
    
    // MARK: - Help methods
    
    func openItemsList() {
        self.currentAnimationState = .opened
        tableViewContainerHeightConstraint.constant = openListHeight
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            self.blurView.alpha = 1
            self.bottomViewImageView.transform = CGAffineTransform(rotationAngle: self.tableViewContainerHeightConstraint.constant != 20 ? CGFloat(Double.pi) : 0)
        }

    }
    
    func closeItemsList() {
        self.currentAnimationState = .closed
        tableViewContainerHeightConstraint.constant = 20
        UIView.animate(withDuration: 0.3) {
            self.blurView.alpha = 0
            self.view.layoutIfNeeded()
            self.bottomViewImageView.transform = CGAffineTransform(rotationAngle: self.tableViewContainerHeightConstraint.constant != 20 ? CGFloat(Double.pi) : 0)
        }
    }
    
    func registerGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        self.sceneView.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        self.view.addGestureRecognizer(panGesture)
    }
    
    func addItem(hitTest: ARHitTestResult) {
        guard let node = self.chosenNode else { return }
        let worldPosition = hitTest.worldTransform
        
        node.position = SCNVector3(worldPosition.columns.3.x, worldPosition.columns.3.y, worldPosition.columns.3.z)
        
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    // MARK: - ARSCNViewDelegate
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
}
