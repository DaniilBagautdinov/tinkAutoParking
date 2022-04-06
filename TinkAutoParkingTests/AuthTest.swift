//
//  AuthTest.swift
//  TinkAutoParkingTests
//
//  Created by Даниил Багаутдинов on 27.03.2022.
//

import XCTest
import FirebaseAuth
import FirebaseFirestore
@testable import TinkAutoParking

class AuthTest: XCTestCase {

    var regVC: RegViewController!
    var authVC: AuthViewController!
    var alertFactory: AlertFactory!
    var authAssembly: AuthAssembly!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        regVC = RegViewController()
        authVC = AuthViewController()
        alertFactory = AlertFactory()
        authAssembly = AuthAssembly()
    }

    override func tearDownWithError() throws {
        regVC = nil
        authVC = nil
        alertFactory = nil
        authAssembly = nil
    }

    func testEmailValidation() throws {
        //Given
        let email = "true@yandex.ru"
        var validateResult: Bool
        let expectedResult = true
        
        //When
        validateResult = regVC.isValidEmail(email)
        
        //Then
        XCTAssertEqual(validateResult, expectedResult)
    }
    
    func testPasswordlValidation() throws {
        //Given
        let password = "Lol123456"
        var validateResult: Bool
        let expectedResult = true
        
        //When
        validateResult = regVC.isValidPassword(password)
        
        //Then
        XCTAssertEqual(validateResult, expectedResult)
    }
    
    func testCreatePasswordDoNotMatchAlert() throws {
        //Given
        let expectedResult = "Ошибка совпадения паролей"
        
        //When
        let alert = alertFactory.buildPasswordDoNotMatchAlert()
        
        //Then
        XCTAssertEqual(alert.title?.description, expectedResult)
    }
    
    func testAssemblySuccess() throws {
        //Given
        let expectedResult = true
        
        //When
        let result = authAssembly.assemble()
        
        //Then
        XCTAssertEqual(result.isKind(of: AuthViewController.self), expectedResult)
    }
    
    func testGetUserCollection() throws {
        //Given
        let dataBase = Firestore.firestore()
        
        //When
        var usersRef: CollectionReference {
            return dataBase.collection("users")
        }
        
        //Then
        XCTAssertNotNil(usersRef)
    }
}

