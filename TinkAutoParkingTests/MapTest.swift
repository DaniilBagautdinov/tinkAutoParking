//
//  TinkAutoParkingTests.swift
//  TinkAutoParkingTests
//
//  Created by Даниил Багаутдинов on 04.03.2022.
//

import XCTest
@testable import TinkAutoParking
import SpriteKit

class MapTest: XCTestCase {
    
    var mapScene: MapScene!
    var mapAssembly: MapAssembly!
    var viewController: MapViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mapScene = MapScene()
        mapAssembly = MapAssembly()
        viewController = MapViewController()
        viewController.viewDidLoad()
    }

    override func tearDownWithError() throws {
        mapScene = nil
        mapAssembly = nil
        viewController = nil
        try super.tearDownWithError()
    }

    func testXCoordinatesSuccess() throws {
        let result = mapScene.xСoordinates(previousCameraPointX: 10, translatrionX: 10, movementSpeed: 10)
        XCTAssertEqual(result, -160)
    }
    
    func testXCoordinatesFail() throws {
        let result = mapScene.xСoordinates(previousCameraPointX: 10, translatrionX: 10, movementSpeed: 10)
        XCTAssertNotEqual(result, -150)
    }
    
    func testYCoordinatesSuccess() throws {
        let result = mapScene.yСoordinates(previousCameraPointY: 10, translatrionY: 10, movementSpeed: 10)
        XCTAssertEqual(result, 180)
    }
    
    func testYCoordinatesFail() throws {
        let result = mapScene.yСoordinates(previousCameraPointY: 10, translatrionY: 10, movementSpeed: 10)
        XCTAssertNotEqual(result, 170)
    }
    
    func testCameraNewScaleCoordinatesSuccess() throws {
        let result = mapScene.cameraNewScaleCoordinates(previousCameraScale: 10, scale: 10)
        XCTAssertEqual(result, 1)
    }
    
    func testCameraNewScaleCoordinatesFail() throws {
        let result = mapScene.cameraNewScaleCoordinates(previousCameraScale: 10, scale: 10)
        XCTAssertNotEqual(result, 3)
    }
    
    func testAssemblySuccess() throws {
        let result = mapAssembly.assemble()
        XCTAssertTrue(result.isKind(of: MapViewController.self))
    }
    
    func testAssemblyFail() throws {
        let result = mapAssembly.assemble()
        XCTAssertFalse(result.isKind(of: AuthViewController.self))
    }
    
    func testSKViewSuccess() throws {
        XCTAssertTrue(viewController.view.isKind(of: SKView.self))
    }
    
    func testSKViewFail() throws {
        XCTAssertFalse(viewController.view.isKind(of: UIImage.self))
    }
}
