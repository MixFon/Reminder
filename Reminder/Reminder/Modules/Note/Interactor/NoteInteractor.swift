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

final class NoteInteractor: NoteBusinessLogic {
    
    private var presenter: NotePresentationLogic?
    
    init(presenter: NotePresentationLogic? = nil) {
        self.presenter = presenter
    }
    
	func makeState(requst: Note.Request) {
		
	}
}
