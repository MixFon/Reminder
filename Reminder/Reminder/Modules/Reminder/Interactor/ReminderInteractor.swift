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
	func getSelectChapter() -> _Chapter?
	func setChapter(chapter: _Chapter?)
	func getChapters() -> [_Chapter]?
}

final class ReminderInteractor: ReminderBusinessLogic, ReminderDataStore {

	private var presenter: ReminderPresentationLogic?
	private let manager = ReminderManager()
	private var selectChapter: _Chapter?
	
	init(presenter: ReminderPresentationLogic?) {
		self.presenter = presenter
	}
	
	func makeState(requst: Reminder.Request) {
		switch requst {
		case .start:
			let chapters = self.manager.getChapters()
			self.presenter?.buildState(response: .work(chapters))
		case .selectChapter(let chapter):
			self.selectChapter = chapter
		}
	}
	
	func getChapters() -> [_Chapter]? {
		return self.manager.getChapters()
	}
	
	func setChapter(chapter: _Chapter?) {
		self.manager.setChapter(chapter: chapter)
	}
	
	func getSelectChapter() -> _Chapter? {
		return self.selectChapter
	}
}
