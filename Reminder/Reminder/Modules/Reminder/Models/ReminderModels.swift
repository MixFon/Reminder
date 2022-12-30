//
//  ReminderModels.swift
//  Reminder
//
//  Created by Михаил Фокин on 04.12.2022.
//

import UIKit
import CoreTableView

protocol _Chapter {
	typealias ChapterIndex = Range<Array<_Chapter>.Index>.Element
	var text: String? { get set }
	var index: ChapterIndex? { get set }
	var notes: [_Note]? { get set }
	var hashValue: Int { get }
	
	mutating func addNote(note: _Note?)
	mutating func updateIndexes()
	mutating func deleteNote(note: _Note?)
	mutating func changeNoteIcon(note: _Note?)
}

protocol _Reminder {
	func getChapters() -> [_Chapter]?
	mutating func setChapter(chapter: _Chapter?)
	mutating func setChapters(chapters: [_Chapter]?)
	mutating func deleteChapter(chapter: _Chapter?)
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

// MARK: _Reminder
extension ReminderModel {
	
	struct Reminder: _Reminder {
		private var chapters: [_Chapter]?
		
		mutating func updateIndexes() {
			for index in (self.chapters ?? []).indices {
				self.chapters?[index].index = index
				self.chapters?[index].updateIndexes()
			}
		}
		
		func getChapters() -> [_Chapter]? {
			return self.chapters
		}
		
		mutating func setChapters(chapters: [_Chapter]?) {
			self.chapters = chapters
			updateIndexes()
		}
		
		mutating func setChapter(chapter: _Chapter?) {
			guard let chapter else { return }
			debugPrint(chapter)
			for index in (self.chapters ?? []).indices {
				if index == chapter.index {
					self.chapters?[index] = chapter
					return
				}
			}
			self.chapters?.append(chapter)
			self.updateIndexes()
		}

		mutating func deleteChapter(chapter: _Chapter?) {
			guard let index = chapter?.index else { return }
			self.chapters?.remove(at: index)
			self.updateIndexes()
		}
	}
}

// MARK: _Chapter
extension ReminderModel {
	
	struct Chapter: _Chapter {
		var text: String?
		var notes: [_Note]?
		var index: ChapterIndex?
		
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
		
		mutating func updateIndexes() {
			for index in (notes ?? []).indices {
				self.notes?[index].index = index
			}
		}
		
		mutating func addNote(note: _Note?) {
			guard let note else { return }
			for index in (notes ?? []).indices {
				if index == note.index {
					self.notes?[index] = note
					return
				}
			}
			self.notes?.append(note)
			updateIndexes()
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
}
