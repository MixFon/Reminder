//
//  ReminderInteractor.swift
//  Reminder
//
//  Created by Михаил Фокин on 04.12.2022.
//

import Foundation

struct MockChapter: _Chapter {
	var notes: [String]?
	var chapter: String?
}

protocol ReminderBusinessLogic: AnyObject {
	func makeState(requst: Reminder.Request)
}

protocol ReminderDataStore {
	var chapters: [_Chapter]? { get }
}

final class ReminderInteractor: ReminderBusinessLogic, ReminderDataStore {

    private var presenter: ReminderPresentationLogic?
	var chapters: [_Chapter]?
    
    init(presenter: ReminderPresentationLogic?) {
        self.presenter = presenter
    }
    
	func makeState(requst: Reminder.Request) {
		switch requst {
		case .start:
			let manager = ReminderManager()
			let chapters = manager.getChapters()
			self.presenter?.buildState(response: .work(chapters))
		}
	}
	

}
