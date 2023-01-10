//
//  DBNote+CoreDataProperties.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.01.2023.
//
//

import Foundation
import CoreData


extension DBNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBNote> {
        return NSFetchRequest<DBNote>(entityName: "Note")
    }

    @NSManaged public var isSelect: Bool
    @NSManaged public var text: String?
    @NSManaged public var chapter: DBChapter?

}

extension DBNote : Identifiable {

}
