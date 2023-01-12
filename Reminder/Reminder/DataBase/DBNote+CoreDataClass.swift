//
//  DBNote+CoreDataClass.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.01.2023.
//
//

import Foundation
import CoreData

@objc(DBNote)
public class DBNote: NSManagedObject, _Note {
	var index: NoteIndex?
	var image: IconNote?
	var hachValue: Int?
	

}
