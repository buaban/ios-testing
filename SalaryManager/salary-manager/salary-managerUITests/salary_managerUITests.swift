//
//  salary_managerUITests.swift
//  salary-managerUITests
//
//  Created by Chuentiwa Chuencharoensuk on 10/11/16.
//  Copyright © 2016 Buataitom. All rights reserved.
//

import XCTest

class salary_managerUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        let app = XCUIApplication()
        app.pickerWheels.allElementsBoundByIndex.first?.adjust(toPickerWheelValue: "SGD")
        var value = (app.tables.cells.allElementsBoundByIndex[0].staticTexts.allElementsBoundByIndex[0].value == nil) ? "" : String(describing: app.tables.cells.allElementsBoundByIndex[0].staticTexts.allElementsBoundByIndex[1].value)
        debugPrint("Value: \(value)")
        
        XCTAssertEqual(value, "Optional(2,311.99)")
        
        app.pickerWheels.allElementsBoundByIndex.first?.adjust(toPickerWheelValue: "THB")
        value = (app.tables.cells.allElementsBoundByIndex[4].staticTexts.allElementsBoundByIndex[0].value == nil) ? "" : String(describing: app.tables.cells.allElementsBoundByIndex[0].staticTexts.allElementsBoundByIndex[1].value)
        XCTAssertEqual(value, "Optional(57,535)")
        
        app.tables.cells.allElementsBoundByIndex[4].tap()
    }
    
}
