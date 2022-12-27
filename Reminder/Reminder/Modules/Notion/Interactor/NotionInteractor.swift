//
//  NotionInteractor.swift
//  Reminder
//
//  Created by Михаил Фокин on 21.12.2022.
//

import Foundation

protocol NotionBusinessLogic: AnyObject {
	func makeState(requst: NotionModel.Request)
}

protocol NotionDataStore {
	func getNote() -> _Note?
	func setNotion(notion: _Notion?)
}

final class NotionInteractor: NotionBusinessLogic {
    
    private var presenter: NotionPresentationLogic?
	private var notion: _Notion?
	
    init(presenter: NotionPresentationLogic?) {
        self.presenter = presenter
    }
	
	func makeState(requst: NotionModel.Request) {
		switch requst {
		case .start:
			self.presenter?.buildState(response: .start)
		case .work:
			self.presenter?.buildState(response: .work(self.notion))
		case .selectNotion(let notion):
			self.notion = notion
		case .changeText(let text):
			self.notion?.text = text
			self.presenter?.buildState(response: .work(self.notion))
		}
	}
    
}

extension NotionInteractor: NotionDataStore {
	
	func getNote() -> _Note? {
		return NoteModel.Note(text: self.notion?.text, image: nil)
	}
	
	func setNotion(notion: _Notion?) {
		self.notion = notion
	}
}
