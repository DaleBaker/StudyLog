//
//  TimeSetCoreData.swift
//  Study Log
//
//  Created by Dale Baker on 28/06/16.
//  Copyright © 2016 NedCorp. All rights reserved.
//

import Foundation
import CoreData

class TimeSetCoreData {
    
    static func retrieveTimeSets() -> [TimeSet]?{
        let entityDescription = NSEntityDescription.entityForName("TimeSlot", inManagedObjectContext: managedContext)
        fetchRequest.entity = entityDescription
        
        do {
            let result = try managedContext.executeFetchRequest(fetchRequest) as? [TimeSet]
            return result
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return nil
        }
    }
    
    static func deleteAllTimeSets() {
        let timeSlots = retrieveTimeSets()
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
    
    static func returnTimeSetWithName(name: String) -> TimeSet? {
        let timeSets = retrieveTimeSets()
        if timeSets != nil {
            for item in timeSets! {
                if (item.name == name) {
                    return item
                }
            }
        }
        return nil
    }
    
    static func returnTempTimeSet() -> TimeSet? {
        return returnTimeSetWithName("temp")
    }
    
    static func returnMainTimeSet() -> TimeSet? {
        return returnTimeSetWithName("main")
    }
    
    static func retrieveTempTimeSet() {
        tempTimeSet = TimeSetCoreData.returnTempTimeSet()
        if (tempTimeSet == nil) {
            tempTimeSet = NSEntityDescription.insertNewObjectForEntityForName("TimeSet", inManagedObjectContext: managedContext) as? TimeSet
            tempTimeSet!.name = "temp"
            do {
                try managedContext.save()
            }
            catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
    }
    
    static func retrieveMainTimeSet() {
        mainTimeSet = TimeSetCoreData.returnMainTimeSet()
        if (mainTimeSet == nil) {
            mainTimeSet = NSEntityDescription.insertNewObjectForEntityForName("TimeSet", inManagedObjectContext: managedContext) as? TimeSet
            mainTimeSet!.name = "main"
            do {
                try managedContext.save()
            }
            catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
    }
    
}