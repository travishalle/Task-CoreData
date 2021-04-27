//
//  Task+Convenience.swift
//  Task-CoreData
//
//  Created by Travis Halle on 4/27/21.
//

import CoreData

extension Task {
    @discardableResult convenience init(name: String, notes: String, dueDate: Date, uuid: String = UUID().uuidString, isComplete: Bool = false, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.notes = notes
        self.uuid = uuid
        self.dueDate = dueDate
        self.isComplete = isComplete
    }
    
    

}//End of extension
