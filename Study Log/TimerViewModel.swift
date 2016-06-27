//
//  TimerViewModel.swift
//  Study Log
//
//  Created by Dale Baker on 7/05/16.
//  Copyright © 2016 NedCorp. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TimerViewModel {
    
    static let timerViewModel = TimerViewModel()
    static let tempTimeSet = TimeSet()
    
    var timerSeconds : Int
    var timerIsRunning : Bool
    var counterValue : Int
    var currentTimeSlot : TimeSlot?
    var counterIteration : Int
    
    init() {
        self.timerSeconds = 0
        self.timerIsRunning = false
        self.counterValue = 0
        self.counterIteration = 0
    }
    
    func timerReset() {
        self.timerIsRunning = false
        self.timerSeconds = 0
        self.counterValue = 0
        currentTimeSlot = nil
        TimeSlotCoreData.deleteAllTimeSlots()
    }
    
    func updateTime() {
        self.timerSeconds = self.currentTimeSlot!.timeSinceBeginDate()
        self.counterIteration = (self.timerSeconds / 3600) % 4
        self.counterValue = (self.timerSeconds % 3600) / 8 //graphic update every 8 seconds
    }
    
    func pause() {
        self.timerIsRunning = false
    }
    
    func createNewTimeSlot() {
        self.currentTimeSlot = NSEntityDescription.insertNewObjectForEntityForName("TimeSlot", inManagedObjectContext: managedContext) as? TimeSlot
        self.currentTimeSlot!.createTimeSlot(NSDate())
        do {
            try managedContext.save()
        }
        catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func retrieveTimeSlot() {
        currentTimeSlot = TimeSlotCoreData.returnCurrentTimeSlot()
        if (currentTimeSlot != nil) {
            self.timerIsRunning = true
        }

    }
    
    
}
