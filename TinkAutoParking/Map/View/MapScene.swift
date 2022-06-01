//
//  GameScene.swift
//  TinkAutoParking
//
//  Created by Даниил Багаутдинов on 09.03.2022.
//

import SpriteKit
import GameplayKit

protocol MapSceneDelegate: AnyObject {
    func showScreen(id: Int)
}

class MapScene: SKScene, UIGestureRecognizerDelegate {
    
    let layer: SKNode!
    
    let demoCamera: Camera!
    
    var startPositionCamera = CGPoint()
    
    var initialScale: CGFloat = 1.0
    
    var sprites: [SKSpriteNode] = []
    
    var profileButton = SKSpriteNode(color: .red, size: CGSize(width: 20, height: 20))
    
    weak var delegatee: MapSceneDelegate?
    
    let mapModel: MapModel = MapModel()
    
    // MARK: Initializers
    
    override init(size: CGSize) {
        layer = SKNode()
        layer.position = CGPoint(x: 0, y: 0)
        demoCamera = Camera()
        demoCamera.showScale()
        demoCamera.showPosition()
        demoCamera.showViewport()
        super.init(size: size)
        backgroundColor = SKColor.lightGray
        addChild(demoCamera)
        camera = demoCamera
        addChild(layer)
        addGamePieces()
        mapModel.updatePlace(sprites: sprites)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Coder not used in this app")
    }
    
    // MARK: Scene Lifecycle
    
    override func didMove(to view: SKView) {
        let panGesture = UIPanGestureRecognizer()
        panGesture.addTarget(self, action: #selector(handlePanGesture(recognizer:)))
        panGesture.delegate = self
        self.view!.addGestureRecognizer(panGesture)
        let pinchGesture = UIPinchGestureRecognizer()
        pinchGesture.addTarget(self, action: #selector(handlePinchGesture(recognizer:)))
        self.view!.addGestureRecognizer(pinchGesture)
    }
    
    override func update(_ currentTime: TimeInterval) {
        demoCamera.update()
    }
    
    // MARK: Touch-based event handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        demoCamera.stop()
        startPositionCamera = demoCamera.position
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first  {
            if startPositionCamera == demoCamera.position {
                let location = touch.location(in: self)
                let node:SKNode = self.atPoint(location)
                var count = 0
                for sprite in sprites {
                    if sprite.position.equalTo(node.position) {
                        delegatee?.showScreen(id: count)
                    }
                    count += 1
                }
            }
        }
    }
    
    @objc func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        demoCamera.position = CGPoint(x: demoCamera.position.x - (translation.x * demoCamera.xScale),
                                      y: demoCamera.position.y + (translation.y * demoCamera.yScale))
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        if (recognizer.state == .ended) {
            let panVelocity = (recognizer.velocity(in: view))
            demoCamera.setCameraPositionVelocity(x: panVelocity.x / 100, y: panVelocity.y / 100)
        }
    }
    
    @objc func handlePinchGesture(recognizer: UIPinchGestureRecognizer) {
        if (recognizer.state == .began) {
            print("Initial Scale: \(initialScale)")
        }
        
        if (recognizer.state == .changed) {
            let deltaScale = recognizer.scale - 1.0;
            var scaleMultiplier = 1.0 - deltaScale;
            if (demoCamera.xScale < demoCamera.range.z.min ||
                demoCamera.xScale > demoCamera.range.z.max) {
                scaleMultiplier = 1.0
            }
            demoCamera.setScale(demoCamera.xScale * scaleMultiplier)
            if (demoCamera.xScale < demoCamera.range.z.min) {
                demoCamera.setScale(demoCamera.range.z.min)
            }
            if (demoCamera.xScale > demoCamera.range.z.max) {
                demoCamera.setScale(demoCamera.range.z.max)
            }
            recognizer.scale = 1.0
        }
        
        if (recognizer.state == .ended) {
            demoCamera.setCameraScaleVelocity(z: recognizer.velocity / 100)
            print("Final Scale = \(demoCamera.xScale)")
        }
        
    }
    
    // MARK: Gesture Recognizer Delegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true;
    }
    
    
    // MARK: Private Functions
    
    private func addGamePieces() {
        profileButton.position = CGPoint(x: 100, y: 100)
        let columns = 4
        let rows = 8
        let tileSet = SKTileSet(named: "Sample Grid Tile Set")!
        let tileSize = CGSize(width: 128, height: 128)
        let sandTiles = tileSet.tileGroups.first { $0.name == "Sand"}
        let bottomLayer = SKTileMapNode(tileSet: tileSet, columns: columns, rows: rows, tileSize: tileSize)
        bottomLayer.fill(with: sandTiles)
        layer.addChild(bottomLayer)
        for column in 0...columns - 1 {
            for row in 0...rows - 1 {
                let spriteGamePiece = SKSpriteNode(imageNamed: "tile")
                spriteGamePiece.position = CGPoint(x: (column * 120) - (columns * 60) + 60, y: (row * 120) - (rows * 60) + 60)
                layer.addChild(spriteGamePiece)
                sprites.append(spriteGamePiece)
            }
        }
        let centerGamePiece = SKShapeNode(circleOfRadius: 5.0)
        centerGamePiece.strokeColor = .red
        centerGamePiece.fillColor = .red
        centerGamePiece.position = CGPoint(x: 0, y: 0)
        layer.addChild(centerGamePiece)
    }
}
