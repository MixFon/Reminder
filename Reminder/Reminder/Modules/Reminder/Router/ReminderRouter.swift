//
//  ReminderRouter.swift
//  Reminder
//
//  Created by Михаил Фокин on 04.12.2022.
//

import UIKit

protocol ReminderRoutingLogic {
	func presentController()
}

protocol ReminderDataPassing {
	var dataStore: ReminderDataStore? { get set }
}

final class ReminderRouter: ReminderRoutingLogic, ReminderDataPassing {
  
    private weak var controller: ReminderController?
	var dataStore: ReminderDataStore?
  
    init(controller: ReminderController? = nil) {
        self.controller = controller
    }
	
	func presentController() {
		let noteController = NoteController()
		noteController.modalPresentationStyle = .fullScreen
		noteController.setPipe(pipe: self)
		self.controller?.present(noteController, animated: true)
	}

}

extension ReminderRouter: NotePipe {
	
	func acceptChapter() -> _Chapter? {
		let chapter = self.dataStore?.getSelectChapter()
		return chapter
	}
	
	func returnChapter(chapter: _Chapter?) {
		self.dataStore?.setChapter(chapter: chapter)
	}
}
