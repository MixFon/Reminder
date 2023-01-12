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
	var index: ChapterIndex?
	var notes: [_Note]?
	
	func addNote(note: _Note?) {
		guard let dbNote = note as? DBNote else {
			return
		}
		self.addToNote(dbNote)
	}
	
	func updateIndexes() {
		
	}
	
	func deleteNote(note: _Note?) {
		guard let dbNote = note as? DBNote else {
			return
		}
		self.removeFromNote(dbNote)
	}
	
	func changeNoteIcon(note: _Note?) {
		let newNote = DBNote()
		newNote.text = note?.text
		self.addToNote(newNote)
	}
}
