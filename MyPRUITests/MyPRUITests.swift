//
//  MyPRUITests.swift
//  MyPRUITests
//
//  Created by Peter Gelsomino on 8/23/18.
//  Copyright © 2018 PeteGels. All rights reserved.
//

import XCTest

class MyPRUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTakeScreenShots() {
        
        let app = XCUIApplication()
        snapshot("0LoginScreen")
        app.textFields["Email"].tap()
        app.textFields["Email"].typeText("plgelsomino@gmail.com")
        app.secureTextFields["Password"].tap()
        app.secureTextFields["Password"].typeText("gamechanger")
        
        app.buttons["Login"].tap()
        
        snapshot("1DashboardScreen")
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Back Squat"]/*[[".cells.staticTexts[\"Back Squat\"]",".staticTexts[\"Back Squat\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        snapshot("2LiftScreenTwoRep")
        app/*@START_MENU_TOKEN@*/.buttons["2 REP"]/*[[".segmentedControls.buttons[\"2 REP\"]",".buttons[\"2 REP\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("3LiftScreenThreeRep")
        app/*@START_MENU_TOKEN@*/.buttons["3 REP"]/*[[".segmentedControls.buttons[\"3 REP\"]",".buttons[\"3 REP\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        
        app.tabBars.buttons["History"].tap()
        snapshot("4HistoryScreen")

        let tablesQuery = app.tables
        let previousLift = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Jul 02, 2018"]/*[[".cells.staticTexts[\"Jul 02, 2018\"]",".staticTexts[\"Jul 02, 2018\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        previousLift.swipeLeft()
        snapshot("5HistoryDeleteScreen")

        previousLift.tap()
        
        app.navigationBars["Back Squat"].buttons["My PRs"].tap()
        
        app.navigationBars["My PRs"].buttons["Add"].tap()
        snapshot("6RecordLiftScreen")

        let dateOfLiftStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Date of Lift"]/*[[".cells.staticTexts[\"Date of Lift\"]",".staticTexts[\"Date of Lift\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        dateOfLiftStaticText.tap()
        snapshot("7ChooseDateScreen")
        dateOfLiftStaticText.tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Choose Lift"]/*[[".cells.staticTexts[\"Choose Lift\"]",".staticTexts[\"Choose Lift\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("8ChooseLiftScreen")
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Front Squat"]/*[[".cells.staticTexts[\"Front Squat\"]",".staticTexts[\"Front Squat\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let chooseRepsStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Choose Reps"]/*[[".cells.staticTexts[\"Choose Reps\"]",".staticTexts[\"Choose Reps\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        chooseRepsStaticText.tap()
        snapshot("9ChooseRepsScreen")
        chooseRepsStaticText.tap()
        app.navigationBars["Record Lift"].buttons["Cancel"].tap()
        
        app.navigationBars["My PRs"].buttons["Sign Out"].tap()
        app.alerts["Are you sure you want to logout?"].buttons["Yes"].tap()
        app.buttons["Sign Up"].tap()
        snapshot("10SignUpScreen")
    }
    
}
