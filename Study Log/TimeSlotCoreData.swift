//
//  TimeSlotCoreData.swift
//  Study Log
//
//  Created by Dale Baker on 27/06/16.
//  Copyright © 2016 NedCorp. All rights reserved.
//

import Foundation
import CoreData

class TimeSlotCoreData {
    
    static func retrieveTimeSlots() -> [TimeSlot]?{
        let entityDescription = NSEntityDescription.entityForName("TimeSlot", inManagedObjectContext: managedContext)
        fetchRequest.entity = entityDescription
        
        do {
            let result = try managedContext.executeFetchRequest(fetchRequest) as? [TimeSlot]
            return result
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return nil
        }
    }
    
    static func deleteAllTimeSlots() {
        let timeSlots = retrieveTimeSlots()
        if (timeSlots != nil) {
            for item in timeSlots! {
                managedContext.deleteObject(item)
            }
            do {
                try managedContext.save()
            } catch {
                let saveError = error as NSError
                print(saveError)
            }
        }
    }
    
    static func returnCurrentTimeSlot() -> TimeSlot? {
        let timeSlots = retrieveTimeSlots()
        if (timeSlots?.count != 0) {
            return timeSlots![0]
        }
        return nil
    }
    
}
