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
	func getText() -> String?
	func setText(text: String)
}

final class NotionInteractor: NotionBusinessLogic {
    
    private var presenter: NotionPresentationLogic?
	private var text: String?
	
    init(presenter: NotionPresentationLogic?) {
        self.presenter = presenter
    }
	
	func makeState(requst: Notion.Request) {
		switch requst {
		case .start:
			self.presenter?.buildState(response: .start)
		case .work(let text):
			self.presenter?.buildState(response: .work(text))
		}
	}
    
}

extension NotionInteractor: NotionDataStore {
	
	func getText() -> String? {
		return self.text
	}
	func setText(text: String) {
		self.text = text
	}
}
