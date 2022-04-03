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
    
    var mapAssembly: MapAssembly!
    var viewController: MapViewController!
    var camera: Camera!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mapAssembly = MapAssembly()
        viewController = MapViewController()
        viewController.view = SKView()
        viewController.viewDidLoad()
    }

    override func tearDownWithError() throws {
        mapAssembly = nil
        viewController = nil
        camera = nil
        try super.tearDownWithError()
    }

    func testXCoordinatesSuccess() throws {
        let result = viewController.demoScene.demoCamera.XCoordinates()
        print(result)
        XCTAssertEqual(result, -50)
    }
    
    func testXCoordinatesFail() throws {
        let result = viewController.demoScene.demoCamera.XCoordinates()
        XCTAssertNotEqual(result, -60)
    }
    
    func testYCoordinatesSuccess() throws {
        let result = viewController.demoScene.demoCamera.yCoordinates(height: 100)
        XCTAssertEqual(result, 100)
    }
    
    func testYCoordinatesFail() throws {
        let result = viewController.demoScene.demoCamera.yCoordinates(height: 70)
        XCTAssertNotEqual(result, 100)
    }
    
    func testShowViewport() throws {
        XCTAssertEqual(viewController.demoScene.demoCamera.childNode(withName: "viewportLabel"), viewController.demoScene.demoCamera.viewportLabel)
    }
    
    func testCameraNewScaleCoordinatesFail() throws {
        XCTAssertNotEqual(viewController.demoScene.demoCamera.childNode(withName: "viewportLabel"), viewController.demoScene.demoCamera.positionLabel)
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
