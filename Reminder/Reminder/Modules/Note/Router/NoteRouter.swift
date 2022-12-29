//
//  NoteRouter.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.12.2022.
//

import UIKit

protocol NoteRoutingLogic {
	func setPipe(pipe: NotePipe?)
	func acceptData()
	func returnChapter()
	func presentNotion()
}

/// Протокол для передачи данных между роутерами.
/// Подписывается роутер из которого передаются данные
protocol NotePipe {
	func returnChapter(chapter: _Chapter?)
	func acceptChapter() -> _Chapter?
}

final class NoteRouter: NoteRoutingLogic {
	
	private weak var controller: NoteController?
	private var pipe: NotePipe?
	
	var dataStore: (NoteDataStore & NotionPipe)?
	
	init(controller: NoteController? = nil) {
		self.controller = controller
	}
	
	func returnChapter() {
		let chapter = self.dataStore?.getChapter()
		self.controller?.dismiss(animated: true) {
			self.pipe?.returnChapter(chapter: chapter)
		}
	}
	
	func setPipe(pipe: NotePipe?) {
		self.pipe = pipe
	}
	
	func acceptData() {
		let chapter = self.pipe?.acceptChapter()
		self.dataStore?.setChapter(chapter: chapter)
	}
	
	func presentNotion() {
		let notion = NotionController()
		notion.setPipe(pipe: self.dataStore)
		notion.modalPresentationStyle = .popover
		self.controller?.present(notion, animated: true)
	}
}
