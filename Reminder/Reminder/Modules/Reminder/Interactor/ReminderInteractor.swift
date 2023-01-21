//
//  ReminderInteractor.swift
//  Reminder
//
//  Created by Михаил Фокин on 04.12.2022.
//

import Foundation

protocol ReminderBusinessLogic: AnyObject {
	func makeState(requst: ReminderModel.Request)
}

protocol ReminderDataStore {
	func getChapters() -> [_Chapter]?
}

final class ReminderInteractor: ReminderBusinessLogic, ReminderDataStore {

	private var notion: _Notion?
	private var manager: ReminderManager?
	private var presenter: ReminderPresentationLogic?
	private var selectChapter: _Chapter?
	
	init(presenter: ReminderPresentationLogic?) {
		self.presenter = presenter
		self.manager = ReminderManager()
	}
	
	func makeState(requst: ReminderModel.Request) {
		switch requst {
		case .start:
			let chapters = self.manager?.getChapters()
			self.presenter?.buildState(response: .work(chapters))
		case .add:
			self.selectChapter = manager?.getNewChapter()
			self.notion = NotionModel.Notion(
				text: nil,
				title: "Введите название нового раздела",
				buttonTitle: "Добавить"
			)
		case .delete(let chapter):
			self.selectChapter = nil
			self.manager?.deleteChapter(chapter: chapter)
			self.makeState(requst: .start)
		case .edit(let chapter):
			self.selectChapter = chapter
			self.notion = NotionModel.Notion(
				text: chapter?.text,
				title: "Изменение названия раздела",
				buttonTitle: "Изменить"
			)
		case .selectChapter(let chapter):
			self.selectChapter = chapter
		}
	}
	
	func getChapters() -> [_Chapter]? {
		return self.manager?.getChapters()
	}
}

// MARK: NotionPipe
extension ReminderInteractor: NotionPipe {
	
	func acceptData() -> _Notion? {
		return self.notion
	}
	
	func returnNotion(notion: _Notion?) {
		self.notion = notion
		self.selectChapter?.text = notion?.text
		self.manager?.updateOrSaveChapter(chapter: self.selectChapter)
		makeState(requst: .start)
	}
}

// MARK: NotePipe
extension ReminderInteractor: NotePipe {
	
	func acceptChapter() -> _Chapter? {
		return self.selectChapter
	}
}
