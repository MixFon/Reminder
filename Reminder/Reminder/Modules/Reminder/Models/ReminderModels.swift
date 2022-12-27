//
//  ReminderModels.swift
//  Reminder
//
//  Created by Михаил Фокин on 04.12.2022.
//

import UIKit
import CoreTableView

protocol _Chapter {
	var notes: [_Note]? { get set }
	var chapter: String? { get }
	
	mutating func addNote(note: _Note?)
	mutating func updateIndexes()
	mutating func deleteNote(note: _Note?)
	mutating func changeNoteIcon(note: _Note?)
}


enum ReminderModel {
	
	struct Chapter: _Chapter {
		var notes: [_Note]?
		var chapter: String?

		
		mutating func addNote(note: _Note?) {
			guard let note else { return }
			debugPrint(note)
			for index in (notes ?? []).indices {
				if index == note.index {
					self.notes?[index] = note
					return
				}
			}
			self.notes?.append(note)
			updateIndexes()
		}
		
		mutating func updateIndexes() {
			for index in (notes ?? []).indices {
				self.notes?[index].index = index
			}
		}
		
		mutating func deleteNote(note: _Note?) {
			guard let index = note?.index else { return }
			self.notes?.remove(at: index)
			updateIndexes()
		}
		
		mutating func changeNoteIcon(note: _Note?) {
			guard let note else { return }
			for index in (notes ?? []).indices {
				if index == note.index {
					self.notes?[index].image?.opositeImage()
					return
				}
			}
		}
	}
	
    enum Request {
		case start
		case selectChapter(_Chapter?)
    }
    
    enum Response {
		case start
		case work([_Chapter]?)
    }
    
	enum ViewModel {
		case display(ReminderShow)
		case present(_Chapter)
		
		struct Show: ReminderShow {
			var states: [State]?
		}
    }
}
