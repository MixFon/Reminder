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

}

final class NoteInteractor: NoteBusinessLogic, NoteDataStore {
    
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
