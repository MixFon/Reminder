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
	func getChapter() -> _Chapter?
	func setChapter(chapter: _Chapter?)
}

final class NoteInteractor: NoteBusinessLogic {
    
    private var presenter: NotePresentationLogic?
	private var chapter: _Chapter?
    
	init(presenter: NotePresentationLogic? = nil) {
        self.presenter = presenter
    }
    
	func makeState(requst: Note.Request) {
		switch requst {
		case .start:
			self.presenter?.buildState(response: .work(self.chapter))
		}
	}
}

extension NoteInteractor: NoteDataStore {
	
	func setChapter(chapter: _Chapter?) {
		self.chapter = chapter
	}
	
	func getChapter() -> _Chapter? {
		return self.chapter
	}
}
