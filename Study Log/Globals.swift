//
//  Globals.swift
//  Study Log
//
//  Created by Dale Baker on 25/06/16.
//  Copyright © 2016 NedCorp. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
let managedContext = appDelegate.managedObjectContext
let fetchRequest = NSFetchRequest()

let timerModel = TimerViewModel()
var timer = NSTimer()

var tempTimeSet : TimeSet?
var mainTimeSet : TimeSet?

func resetAll() {
    timerModel.timerReset()
    TimeDataCoreData.deleteAllTimeData()
    TimeSetCoreData.deleteAllTimeSets()
    TimeSlotCoreData.deleteAllTimeSlots()
}