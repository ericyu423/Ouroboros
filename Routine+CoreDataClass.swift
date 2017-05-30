//
//  Routine+CoreDataClass.swift
//  Ouroboros
//
//  Created by eric yu on 5/30/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import Foundation
import CoreData

class Routine: NSManagedObject {
    
    @NSManaged public var index: Int32
    @NSManaged public var isArchive: Bool
    @NSManaged public var isMorning: Bool
    @NSManaged public var isNight: Bool
    @NSManaged public var toDo: String?
    @NSManaged public var histories: History?
    
}
