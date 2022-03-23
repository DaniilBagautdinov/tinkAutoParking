//
//  GameScene.swift
//  testProj1
//
//  Created by Даниил Багаутдинов on 09.03.2022.
//

import SpriteKit
import GameplayKit

class MapScene: SKScene {
    
    private var tileMapNode : SKTileMapNode?
    
    var previousCameraPoint = CGPoint.zero
    var previousCameraScale = CGFloat()
    var movementSpeed = CGFloat(1)
    
    
    override func didMove(to view: SKView) {
        self.tileMapNode = self.childNode(withName: "//tileMapNode") as? SKTileMapNode
        let panGesture = UIPanGestureRecognizer()
        panGesture.addTarget(self, action: #selector(panGestureAction(_:)))
        view.addGestureRecognizer(panGesture)
        let pinchGesture = UIPinchGestureRecognizer()
        pinchGesture.addTarget(self, action: #selector(pinchGestureAction(_:)))
        view.addGestureRecognizer(pinchGesture)
        
    }
    
    @objc func panGestureAction(_ sender: UIPanGestureRecognizer) {
        // The camera has a weak reference, so test it
        guard let camera = self.camera else {
            return
        }
        // If the movement just began, save the first camera position
        if sender.state == .began {
            previousCameraPoint = camera.position
        }
        // Perform the translation
        let translation = sender.translation(in: self.view)
        let newPosition = CGPoint(
            x: previousCameraPoint.x + translation.x * -movementSpeed * 1.7,
            y: previousCameraPoint.y + translation.y * movementSpeed * 1.7
        )
        camera.position = newPosition
    }
    
    @objc func pinchGestureAction(_ sender: UIPinchGestureRecognizer) {
        guard let camera = self.camera else {
            return
        }
        movementSpeed = camera.xScale
        if sender.state == .began {
            previousCameraScale = camera.xScale
        }
        camera.setScale(previousCameraScale * 1 / sender.scale)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
    }
}
