//
//  TimeSlot+CoreDataProperties.swift
//  Study Log
//
//  Created by Dale Baker on 26/06/16.
//  Copyright © 2016 NedCorp. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension TimeSlot {

    @NSManaged var startDate: NSDate?
    @NSManaged var type: NSNumber?

}
