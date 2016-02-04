//
//  Swift_Digital_Leash_ParentUITests.swift
//  Swift Digital Leash-ParentUITests
//
//  Created by Chris on 1/12/16.
//  Copyright © 2016 Prince Fungus. All rights reserved.
//

import XCTest

class Swift_Digital_Leash_ParentUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testSubmitButtonEnables() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let scrollViewsQuery = XCUIApplication().scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        let submitButton = scrollViewsQuery.buttons["Submit"]
        let usernameTextField = elementsQuery.textFields["username"]
        XCTAssertFalse(submitButton.enabled)
        
        usernameTextField.tap()
        usernameTextField.typeText("f")
        XCTAssertFalse(submitButton.enabled)
        
        let digitalLeashElement = scrollViewsQuery.otherElements.containingType(.StaticText, identifier:"Digital Leash ").element
        digitalLeashElement.tap()
        digitalLeashElement.tap()
        
        let radiusTextField = elementsQuery.textFields["radius"]
        radiusTextField.tap()
        radiusTextField.typeText("2")
        XCTAssertTrue(submitButton.enabled)
    }
    
    func testSubmitButtonDisables() {
        
        let app = XCUIApplication()
        let elementsQuery = app.scrollViews.otherElements
        let submitButton = elementsQuery.buttons["Submit"]
        XCTAssertFalse(submitButton.enabled)
        
        let usernameTextField = elementsQuery.textFields["username"]
        usernameTextField.tap()
        usernameTextField.typeText("t")
        XCTAssertFalse(submitButton.enabled)
        
        let radiusTextField = elementsQuery.textFields["radius"]
        radiusTextField.tap()
        radiusTextField.typeText("2")
        XCTAssertTrue(submitButton.enabled)
        
        let deleteKey = app.keys["Delete"]
        deleteKey.tap()
        deleteKey.tap()
        usernameTextField.tap()
        XCTAssertFalse(submitButton.enabled)
        
        
        let deleteKey2 = app.keys["delete"]
        deleteKey2.tap()
        deleteKey2.tap()
        app.buttons["Done"].tap()
        XCTAssertFalse(submitButton.enabled)
        
        
    }
    
}
