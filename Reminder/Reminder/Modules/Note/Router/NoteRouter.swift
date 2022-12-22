//
//  NoteRouter.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.12.2022.
//

import UIKit

protocol NoteRoutingLogic {
	func setPipe(pipe: NotePipe?)
	func returnChapter()
}

protocol NoteDataPassing {
  var dataStore: NoteDataStore? { get set }
}

/// Протокол для передачи данных между роутерами.
/// Подписывается роутер из которого передаются данные
protocol NotePipe {
	func returnChapter(chapter: _Chapter?)
	func acceptChapter(chapter: _Chapter?)
}

final class NoteRouter: NoteRoutingLogic, NoteDataPassing {
	
	private weak var controller: NoteController?
	private var pipe: NotePipe?
	
	var dataStore: NoteDataStore?
	
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
	
}
