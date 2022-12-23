//
//  NotionInteractor.swift
//  Reminder
//
//  Created by Михаил Фокин on 21.12.2022.
//

import Foundation

protocol NotionBusinessLogic: AnyObject {
	func makeState(requst: Notion.Request)
}

protocol NotionDataStore {
	func getNote() -> _Note?
	func setNote(note: _Note?)
}

final class NotionInteractor: NotionBusinessLogic {
    
    private var presenter: NotionPresentationLogic?
	private var note: _Note?
	
    init(presenter: NotionPresentationLogic?) {
        self.presenter = presenter
    }
	
	func makeState(requst: Notion.Request) {
		switch requst {
		case .start:
			self.presenter?.buildState(response: .start)
		case .work:
			self.presenter?.buildState(response: .work(self.note))
		case .selectNote(let note):
			self.note = note
		}
	}
    
}

extension NotionInteractor: NotionDataStore {
	
	func getNote() -> _Note? {
		return self.note
	}
	
	func setNote(note: _Note?) {
		self.note = note
	}
}
