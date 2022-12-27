//
//  NotionRouter.swift
//  Reminder
//
//  Created by Михаил Фокин on 21.12.2022.
//

import UIKit

protocol NotionRoutingLogic {
	func acceptData()
	func setPipe(pipe: NotionPipe?)
	func presentController()
	func pressChenge()
}

protocol NotionDataPassing {
	var dataStore: NotionDataStore? { get set }
}

/// Протокол для передачи данных между роутерами.
/// Подписывается роутер из которого передаются данные
protocol NotionPipe {
	func acceptData() -> _Notion?
	func returnNote(note: _Note?)
}

final class NotionRouter: NotionRoutingLogic, NotionDataPassing {
	
	private weak var controller: NotionController?
	private var pipe: NotionPipe?
	
	var dataStore: NotionDataStore?
	
	init(controller: NotionController? = nil) {
		self.controller = controller
	}
	
	func presentController() {
		
	}
	
	func setPipe(pipe: NotionPipe?) {
		self.pipe = pipe
	}
	
	func acceptData() {
		let notion = self.pipe?.acceptData()
		self.dataStore?.setNotion(notion: notion)
	}
	
	func pressChenge() {
		self.controller?.dismiss(animated: true) {
			let note = self.dataStore?.getNote()
			self.pipe?.returnNote(note: note)
		}
	}
	
}
