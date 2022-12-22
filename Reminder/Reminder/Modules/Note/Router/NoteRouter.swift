//
//  NoteRouter.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.12.2022.
//

import UIKit

protocol NoteRoutingLogic {
	func setDataAccept(dataAccept: NoteDataAccept?)
	func returnChapter()
}

protocol NoteDataPassing {
  var dataStore: NoteDataStore? { get set }
}

/// Протокол для обработки возвращаемых от других контроллеров данных.
/// Подписывается текущий роутер
protocol NoteDataReturn {
	
}

/// Протокол для обработки устанавливаемых от других контроллеров данных.
/// Подписывается роутер из которого передаются данные
protocol NoteDataAccept {
	
}

final class NoteRouter: NoteRoutingLogic, NoteDataPassing {
	
	private weak var controller: NoteController?
	private var dataAccept: NoteDataAccept?
	
	var dataReturn: ReminderDataReturn?
	
	var dataStore: NoteDataStore?
	
	init(controller: NoteController? = nil, dataReturn: ReminderDataReturn? = nil) {
		self.controller = controller
		self.dataReturn = dataReturn
	}
	
	func returnChapter() {
		let chapter = self.dataStore?.getChapter()
		self.controller?.dismiss(animated: true) {
			self.dataReturn?.returnChangeChapter(chapter: chapter)
		}
	}
	
	func setDataAccept(dataAccept: NoteDataAccept? = nil) {
		self.dataAccept = dataAccept
	}
	
//	
//	func setDataAccept(dataAccept: NoteDataAccept? = nil) {
//		self.dataAccept = dataAccept
//	}
	
}

extension NoteRouter: NoteDataReturn {
	
}
