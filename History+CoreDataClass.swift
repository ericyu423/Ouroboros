//
//  History+CoreDataClass.swift
//  Ouroboros
//
//  Created by eric yu on 5/30/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import Foundation
import CoreData

class History: NSManagedObject {
    
    @NSManaged public var date: NSDate?
    @NSManaged public var isComplete: Bool
    @NSManaged public var routine: Routine

}
