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
    
    override func didMove(to view: SKView) {
        self.tileMapNode = self.childNode(withName: "//tileMapNode") as? SKTileMapNode
        self.camera = self.childNode(withName: "//camera") as? SKCameraNode
        self.camera?.position = CGPoint(x: 1000.0, y: 2000.3)
        let panGesture = UIPanGestureRecognizer()
        panGesture.addTarget(self, action: #selector(panGestureAction(_:)))
        view.addGestureRecognizer(panGesture)
        
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
         x: previousCameraPoint.x + translation.x * -1,
         y: previousCameraPoint.y + translation.y
       )
       camera.position = newPosition
     }
    
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
  
    override func update(_ currentTime: TimeInterval) {
    }
}
