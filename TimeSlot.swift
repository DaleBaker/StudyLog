//
//  TimeSlot.swift
//  Study Log
//
//  Created by Dale Baker on 26/06/16.
//  Copyright © 2016 NedCorp. All rights reserved.
//

import Foundation
import CoreData

@objc(TimeSlot)
class TimeSlot: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    let calendar = NSCalendar.currentCalendar()
    
    func createTimeSlot(startTime: NSDate){
        self.startDate = startTime
    }
    
    func timeSinceBeginDate() -> Int {
        let components = calendar.components([.Second], fromDate: self.startDate!, toDate: NSDate(), options: [])
        
        return components.second
    }
}
