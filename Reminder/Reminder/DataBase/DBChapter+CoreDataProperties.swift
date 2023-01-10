//
//  DBChapter+CoreDataProperties.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.01.2023.
//
//

import Foundation
import CoreData


extension DBChapter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBChapter> {
        return NSFetchRequest<DBChapter>(entityName: "Chapter")
    }

    @NSManaged public var text: String?
    @NSManaged public var note: NSSet?

}

// MARK: Generated accessors for note
extension DBChapter {

    @objc(addNoteObject:)
    @NSManaged public func addToNote(_ value: DBNote)

    @objc(removeNoteObject:)
    @NSManaged public func removeFromNote(_ value: DBNote)

    @objc(addNote:)
    @NSManaged public func addToNote(_ values: NSSet)

    @objc(removeNote:)
    @NSManaged public func removeFromNote(_ values: NSSet)

}

extension DBChapter : Identifiable {

}
