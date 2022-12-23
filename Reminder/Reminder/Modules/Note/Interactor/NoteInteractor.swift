//
//  NoteInteractor.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.12.2022.
//

import Foundation

protocol NoteBusinessLogic: AnyObject {
   func makeState(requst: Note.Request)
}

protocol NoteDataStore {
	func getNote() -> _Note?
	func setNote(note: _Note?)
	func getChapter() -> _Chapter?
	func setChapter(chapter: _Chapter?)
}

final class NoteInteractor: NoteBusinessLogic {
    
    private var presenter: NotePresentationLogic?
	private var chapter: _Chapter?
	private var selectNote: _Note?
    
	init(presenter: NotePresentationLogic? = nil) {
        self.presenter = presenter
    }
    
	func makeState(requst: Note.Request) {
		switch requst {
		case .start:
			self.presenter?.buildState(response: .work(self.chapter))
		case .addNote:
			self.selectNote = DataNote()
			self.presenter?.buildState(response: .addNote)
		}
	}
}

extension NoteInteractor: NoteDataStore {
	
	func getNote() -> _Note? {
		return self.selectNote
	}
	
	func setNote(note: _Note?) {
		guard let note = note else { return }
		self.chapter?.notes?.append(note)
	}
	
	func setChapter(chapter: _Chapter?) {
		self.chapter = chapter
	}
	
	func getChapter() -> _Chapter? {
		return self.chapter
	}
}
