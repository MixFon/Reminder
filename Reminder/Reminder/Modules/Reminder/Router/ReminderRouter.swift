//
//  ReminderRouter.swift
//  Reminder
//
//  Created by Михаил Фокин on 04.12.2022.
//

import UIKit

protocol ReminderRoutingLogic {
	func presentController(chapter: _Chapter?)
}

protocol ReminderDataPassing {
	var dataStore: ReminderDataStore? { get set }
}

protocol ReminderDataReturn {
	func returnChangeChapter(chapter: _Chapter?)
}

final class ReminderRouter: ReminderRoutingLogic, ReminderDataPassing {
  
    private weak var controller: ReminderController?
	var dataStore: ReminderDataStore?
  
    init(controller: ReminderController? = nil) {
        self.controller = controller
    }
	
	func presentController(chapter: _Chapter?) {
		let noteController = NoteController(chapter: chapter, dataReturn: self)
		noteController.modalPresentationStyle = .fullScreen
		self.controller?.present(noteController, animated: true)
	}

}

extension ReminderRouter: ReminderDataReturn {
	
	func returnChangeChapter(chapter: _Chapter?) {
		self.dataStore?.setChapters(chapter: chapter)
	}
}
