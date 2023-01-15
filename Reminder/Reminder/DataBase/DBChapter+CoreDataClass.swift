//
//  DBChapter+CoreDataClass.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.01.2023.
//
//

import Foundation
import CoreData

@objc(DBChapter)
public class DBChapter: NSManagedObject, _Chapter {
	
	var notes: [_Note]? {
		get {
			return self.note?.allObjects as? [DBNote]
		}
		set {
			
		}
	}
	
	func addNote(note: _Note?) {
		guard let dbNote = note as? DBNote else { return }
		self.addToNote(dbNote)
	}
	
	func deleteNote(note: _Note?) {
		guard let dbNote = note as? DBNote else { return }
		self.removeFromNote(dbNote)
	}
}
