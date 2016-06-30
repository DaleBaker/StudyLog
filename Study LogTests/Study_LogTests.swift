//
//  Study_LogTests.swift
//  Study LogTests
//
//  Created by Dale Baker on 14/04/16.
//  Copyright © 2016 NedCorp. All rights reserved.
//

import XCTest
@testable import Study_Log

class Study_LogTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        resetAll()
    }
    
    func testStartThenAdd() {
        let ts = TimerViewController()
        ts.startButtonClicked()
        XCTAssertEqual(timerModel.timerIsRunning, true)
        XCTAssertNotNil(timerModel.currentTimeSlot)
        ts.addButtonClicked()
        XCTAssertEqual(timerModel.timerIsRunning, false)
        XCTAssertNil(timerModel.currentTimeSlot)
        XCTAssertEqual(mainTimeSet?.timeSlots?.count, 1)
    }
    
    func testStartThenMinus() {
        let ts = TimerViewController()
        ts.startButtonClicked()
        XCTAssertEqual(timerModel.timerIsRunning, true)
        XCTAssertNotNil(timerModel.currentTimeSlot)
        ts.minusButtonClicked()
        XCTAssertEqual(timerModel.timerIsRunning, false)
        XCTAssertNil(timerModel.currentTimeSlot)
    }
    
    func testStartThenPause() {
        let ts = TimerViewController()
        ts.startButtonClicked()
        XCTAssertEqual(timerModel.timerIsRunning, true)
        XCTAssertNotNil(timerModel.currentTimeSlot)
        ts.startButtonClicked()
        XCTAssertEqual(timerModel.timerIsRunning, false)
        XCTAssertNil(timerModel.currentTimeSlot)
        XCTAssertNotNil(tempTimeSet)
        XCTAssertEqual(tempTimeSet?.timeSlots?.count, 1)
    }
    
    func testStartThenPauseThenAdd() {
        let ts = TimerViewController()
        ts.startButtonClicked()
        ts.startButtonClicked()
        ts.addButtonClicked()
        XCTAssertEqual(timerModel.timerIsRunning, false)
        XCTAssertNil(timerModel.currentTimeSlot)
        XCTAssertNotNil(tempTimeSet)
        XCTAssertEqual(tempTimeSet?.timeSlots?.count, 0)
        XCTAssertEqual(mainTimeSet?.timeSlots?.count, 1)
    }
    
    func testStartThenPauseThenMinus() {
        let ts = TimerViewController()
        ts.startButtonClicked()
        ts.startButtonClicked()
        ts.minusButtonClicked()
        XCTAssertEqual(timerModel.timerIsRunning, false)
        XCTAssertNil(timerModel.currentTimeSlot)
        XCTAssertNotNil(tempTimeSet)
        XCTAssertEqual(tempTimeSet?.timeSlots?.count, 0)
        XCTAssertEqual(mainTimeSet?.timeSlots?.count, 0)
    }
    
}
