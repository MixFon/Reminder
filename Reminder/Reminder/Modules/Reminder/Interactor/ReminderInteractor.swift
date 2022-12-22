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
	func getChapters() -> [_Chapter]?
	func setChapters(chapter: _Chapter?)
}

final class ReminderInteractor: ReminderBusinessLogic, ReminderDataStore {
	
	private var presenter: ReminderPresentationLogic?
	private let manager = ReminderManager()
	
	init(presenter: ReminderPresentationLogic?) {
		self.presenter = presenter
	}
	
	func makeState(requst: Reminder.Request) {
		switch requst {
		case .start:
			let chapters = self.manager.getChapters()
			self.presenter?.buildState(response: .work(chapters))
		}
	}
	
	func getChapters() -> [_Chapter]? {
		return self.manager.getChapters()
	}
	
	func setChapters(chapter: _Chapter?) {
		
	}

}
