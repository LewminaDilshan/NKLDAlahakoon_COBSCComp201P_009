//
//  SignINViewTest.swift
//  NKLDAlahakoon_COBSCComp201P_009UITests
//
//  Created by Lewmina Dilshan on 2021-11-25.
//

import XCTest

class SignINViewTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testSignIn() throws {
        // Use recording to get started writing UI tests.        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let app = XCUIApplication()
        app.tabBars["Tab Bar"].buttons["Bookings"].tap()
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.segmentedControls.buttons["Create Account"].tap()
        elementsQuery/*@START_MENU_TOKEN@*/.buttons["Log In"]/*[[".segmentedControls.buttons[\"Log In\"]",".buttons[\"Log In\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        elementsQuery.buttons["Terms & Conditions"].tap()
        
        let logInButton = app.navigationBars["_TtGC7SwiftUIP13$7fff5695965428DestinationHosting"].buttons["Log In"]
        logInButton.tap()
        elementsQuery.buttons["Forgot Password?"].tap()
        logInButton.tap()
        
        let emailTextField = elementsQuery.textFields["Email"]
        emailTextField.tap()
        
        let passwordSecureTextField = elementsQuery.secureTextFields["Password"]
        passwordSecureTextField.tap()
        emailTextField.tap()
        
        let logInButton2 = scrollViewsQuery.otherElements.containing(.textField, identifier:"Email").children(matching: .button)["Log In"]
        logInButton2.tap()
                   
               
    }

}
