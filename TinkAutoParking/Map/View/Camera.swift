//
//  Camera.swift
//  TinkAutoParking
//
//  Created by Даниил Багаутдинов on 29.03.2022.
//

import SpriteKit
import os.log

class Camera: SKCameraNode {
    
    // MARK: Properties
    
    private var velocity: (x: CGFloat, y: CGFloat, z: CGFloat) = (0, 0, 0)
    
    private var friction: CGFloat = 0.95
    
    private var attraction: (x: CGFloat, y: CGFloat, z: CGFloat) = (0, 0, 0)
    
    private var attractiveForce: CGFloat = 0.25
    
    var range: (x: (min: CGFloat, max: CGFloat),
                y: (min: CGFloat, max: CGFloat),
                z: (min: CGFloat, max: CGFloat)) = ((-60, 60), (-60, 170),(0.25, 1))
    
    private var showsPosition = false
    
    private var showsScale = false
    
    private var showsViewport = false
    
    let positionLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-SemiBold")
    
    let scaleLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-SemiBold")
    
    let viewportLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-SemiBold")
    
    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Coder not used in this app")
    }
    
    
    // MARK: Camera Property Setters
    
    func setCameraVelocity(x: CGFloat!, y: CGFloat!, z: CGFloat!) {
        setCameraPositionVelocity(x: x, y: y)
        if (z != nil) {
            setCameraScaleVelocity(z: z)
        }
    }
    
    func setCameraPositionVelocity(x: CGFloat!, y: CGFloat!) {
        if (x != nil) {
            velocity.x = x * xScale
        }
        
        if (y != nil) {
            velocity.y = y * yScale
        }
    }
    
    func setCameraScaleVelocity(z: CGFloat) {
        velocity.z = z * xScale
    }
    
    func setCameraFriction(force: CGFloat) {
        if (force <= 0 || force >= 1.0) {
            os_log("Friction should be a number between 0 and 1", type: .error)
        }
        friction = force
    }
    
    func setCameraAttractiveForce(force: CGFloat) {
        if (force <= 0 || force >= 1.0) {
            os_log("Attractive force should be a number between 0 and 1", type: .error)
        }
        attractiveForce = force
    }
    
    
    // MARK: Updating the Camera
    
    func stop() {
        print("Stop Camera Motion")
        velocity = (0.0, 0.0, 0.0)
        attraction = (0.0, 0.0, 0.0)
    }
    
    func update() {
        if (velocity.x != 0 || velocity.y != 0 || attraction.x != 0 || attraction.y != 0) {
            updatePosition()
        }
        
        if (velocity.z != 0 || attraction.z != 0) {
            updateScale()
        }
        
        updateHUD()
        
    }
    
    private func updatePosition() {
        if (position.x < range.x.min) {
            attraction.x = position.x - range.x.min
            attraction.x *= attractiveForce
        } else if (position.x > range.x.max) {
            attraction.x = position.x - range.x.max
            attraction.x *= attractiveForce
        } else {
            attraction.x = 0.0
        }
        if (position.y < range.y.min) {
            attraction.y = position.y - range.y.min
            attraction.y *= attractiveForce
        } else if (position.y > range.y.max) {
            attraction.y = position.y - range.y.max
            attraction.y *= attractiveForce
        } else {
            attraction.y = 0.0
        }
        velocity.x *= friction
        if (abs(velocity.x) < 0.01) {
            velocity.x = 0
        }
        velocity.y *= friction
        if (abs(velocity.y) < 0.01) {
            velocity.y = 0
        }
        position.x -= velocity.x + attraction.x
        position.y += velocity.y - attraction.y
    }
    
    private func applyScaleForces() {
        yScale = xScale
        if (xScale < range.z.min) {
            attraction.z = range.z.min - xScale
            attraction.z *= attractiveForce
        } else if (xScale > range.z.max) {
            attraction.z = range.z.max - xScale
            attraction.z *= attractiveForce
        } else {
            attraction.z = 0
        }
        velocity.z *= friction
    }
    
    // TODO: Applies forces to the camera's scale velocity and then updates the scale
    private func updateScale() {
        applyScaleForces()
        setScale(xScale - velocity.z + attraction.z)
    }
    
    
    // MARK: Heads Up Display
    
    func showPosition() {
        if (!showsPosition) {
            showsPosition = true
            positionLabel.fontSize = 8
            positionLabel.fontColor = .white
            addChild(positionLabel)
        }
    }
    
    func showScale() {
        if (!showsScale) {
            showsScale = true
            scaleLabel.fontSize = 8
            scaleLabel.fontColor = .white
            scaleLabel.position = CGPoint(x:0.0, y: -15.0)
            addChild(scaleLabel)
        }
    }
    
    func showViewport() {
        if (!showsViewport) {
            showsViewport = true
            viewportLabel.fontSize = 8
            viewportLabel.name = "viewportLabel"
            viewportLabel.fontColor = .white
            viewportLabel.position = CGPoint(x:0.0, y: -30.0)
            addChild(viewportLabel)
        }
    }
    
    func XCoordinates() -> CGFloat {
        return parent!.frame.size.width / 2 - 50
    }
    
    func yCoordinates(height: CGFloat) -> CGFloat {
        return -parent!.frame.size.height/2 + height
    }
    
    private func updateHUD() {
        if (showsPosition) {
            let x = position.x.rounded(FloatingPointRoundingRule.toNearestOrEven)
            let y = position.y.rounded(FloatingPointRoundingRule.toNearestOrEven)
            positionLabel.text = "position: (\(x), \(y))"
            positionLabel.position = CGPoint(x:XCoordinates(), y: yCoordinates(height: 30))
        }
        
        if (showsScale) {
            let scale = round(100 * xScale) / 100.0
            scaleLabel.text = "Scale: \(scale)"
            scaleLabel.position = CGPoint(x:XCoordinates(), y: yCoordinates(height: 40))
        }
        
        if (showsViewport) {
            viewportLabel.text = "Viewport: (\(parent!.frame.size.width), \(parent!.frame.size.height))"
            viewportLabel.position = CGPoint(x:XCoordinates(), y: yCoordinates(height: 20))
        }
    }
}
