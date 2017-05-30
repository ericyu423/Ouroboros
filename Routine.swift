//
//  Routine+CoreDataClass.swift
//  Ouroboros
//
//  Created by eric yu on 5/30/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import Foundation
import CoreData


/*
 @NSManaged public var name: String?
 @NSManaged public var index: Int32
 @NSManaged public var isArchive: Bool
 @NSManaged public var isMorning: Bool
 @NSManaged public var isNight: Bool
 @NSManaged public var toDo: String?
 @NSManaged public var histories: History?
 */

class Routine: NSManagedObject {
    
    class func findOrCreateRoutine(routine: Routine,in context: NSManagedObject) -> Routine{
    
        let request: NSFetchRequest<Routine> = Routine.fetchRequest()
        
        request.predicate = NSPredicate(format:"name == %@ AND isMorning == TRUE", routine.name!)
      
        return Routine()
    }
    

    
    
    
}
