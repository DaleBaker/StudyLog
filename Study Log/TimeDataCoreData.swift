//
//  TimeDataCoreData.swift
//  Study Log
//
//  Created by Dale Baker on 28/06/16.
//  Copyright © 2016 NedCorp. All rights reserved.
//

import Foundation
import CoreData

class TimeDataCoreData {
    
    static func retrieveTimeData() -> [TimeData]?{
        let entityDescription = NSEntityDescription.entityForName("TimeData", inManagedObjectContext: managedContext)
        fetchRequest.entity = entityDescription
        
        do {
            let result = try managedContext.executeFetchRequest(fetchRequest) as? [TimeData]
            return result
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return nil
        }
    }
    
    static func deleteAllTimeData() {
        let timeData = retrieveTimeData()
        if (timeData != nil) {
            for item in timeData! {
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
    
    static func deleteTimeDataInTempTimeSet() {
        let timeData = retrieveTimeData()
        if (timeData != nil) {
            for item in timeData! {
                if (item.timeSet == tempTimeSet) {
                    managedContext.deleteObject(item)
                }
            }
            do {
                try managedContext.save()
            } catch {
                let saveError = error as NSError
                print(saveError)
            }
        }
    }

    
}