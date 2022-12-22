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
}

final class NoteInteractor: NoteBusinessLogic {
    
    private var presenter: NotePresentationLogic?
	private var chapter: _Chapter?
    
	init(presenter: NotePresentationLogic? = nil, chapter: _Chapter? = nil) {
        self.presenter = presenter
		self.chapter = chapter
    }
    
	func makeState(requst: Note.Request) {
		switch requst {
		case .start:
			self.presenter?.buildState(response: .work(self.chapter))
		}
	}
}

extension NoteInteractor: NoteDataStore {
	
	func getChapter() -> _Chapter? {
		return self.chapter
	}
}
