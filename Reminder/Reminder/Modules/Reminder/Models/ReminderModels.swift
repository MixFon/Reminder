//
//  ReminderModels.swift
//  Reminder
//
//  Created by Михаил Фокин on 04.12.2022.
//

import UIKit
import CoreTableView

protocol _Chapter {
	var text: String? { get set }
	var notes: [_Note]? { get set }
	var hashValue: Int { get }
	
	mutating func addNote(note: _Note?)
	mutating func deleteNote(note: _Note?)
}

enum ReminderModel {
	
    enum Request {
		case add
		case edit(_Chapter?)
		case start
		case delete(_Chapter?)
		case selectChapter(_Chapter?)
    }
    
    enum Response {
		case start
		case work([_Chapter]?)
    }
    
	enum ViewModel {
		case display(ReminderShow)
		case edit(_Chapter?)
		case delete(_Chapter?)
		case present(_Chapter?)
		
		struct Show: ReminderShow {
			var title: String?
			var states: [State]?
		}
    }
}

// MARK: _Chapter
extension ReminderModel {
	
	struct Chapter: _Chapter {
		var text: String?
		var notes: [_Note]?
		
		var hashValue: Int {
			var hash = 0
			for note in notes ?? [] {
				hash = [hash, note.hachValue].hashValue
			}
			if let text {
				hash = [hash, text.hashValue].hashValue
			}
			return hash
		}
		
//		mutating func updateIndexes() {
//			for index in (notes ?? []).indices {
//				self.notes?[index].index = index
//			}
//		}
		
		mutating func addNote(note: _Note?) {
//			guard let note else { return }
//			for index in (notes ?? []).indices {
//				if index == note.index {
//					self.notes?[index] = note
//					return
//				}
//			}
//			self.notes?.append(note)
//			updateIndexes()
		}

		mutating func deleteNote(note: _Note?) {
//			guard let index = note?.index else { return }
//			self.notes?.remove(at: index)
//			updateIndexes()
		}
		
		mutating func changeNoteIcon(note: _Note?) {
//			guard let note else { return }
//			for index in (notes ?? []).indices {
//				if index == note.index {
//					self.notes?[index].image?.opositeImage()
//					return
//				}
//			}
		}
	}
}
