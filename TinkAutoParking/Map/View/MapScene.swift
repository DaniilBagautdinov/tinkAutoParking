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
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
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
            x: xСoordinates(previousCameraPointX: previousCameraPoint.x, translatrionX: translation.x, movementSpeed: movementSpeed),
            y: yСoordinates(previousCameraPointY: previousCameraPoint.y, translatrionY: translation.y, movementSpeed: movementSpeed)
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
        camera.setScale(cameraNewScaleCoordinates(previousCameraScale: previousCameraScale, scale: sender.scale))
    }
    
    func xСoordinates (previousCameraPointX: CGFloat, translatrionX: CGFloat, movementSpeed: CGFloat) -> CGFloat {
        return previousCameraPointX + translatrionX * -movementSpeed * 1.7
    }
    
    func yСoordinates (previousCameraPointY: CGFloat, translatrionY: CGFloat, movementSpeed: CGFloat) -> CGFloat {
        return previousCameraPointY + translatrionY * movementSpeed * 1.7
    }
    
    func cameraNewScaleCoordinates (previousCameraScale: CGFloat, scale: CGFloat) -> CGFloat{
        return previousCameraScale / scale
    }
}
