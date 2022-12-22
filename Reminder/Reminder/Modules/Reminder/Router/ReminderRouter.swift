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

final class ReminderRouter: ReminderRoutingLogic, ReminderDataPassing {
  
    private weak var controller: ReminderController?
	var dataStore: ReminderDataStore?
  
    init(controller: ReminderController? = nil) {
        self.controller = controller
    }
	
	func presentController(chapter: _Chapter?) {
		let noteController = NoteController()
		noteController.modalPresentationStyle = .fullScreen
		self.controller?.present(noteController, animated: true)
	}

}

extension ReminderRouter: NotePipe {
	func acceptChapter(chapter: _Chapter?) {
		
	}
	
	func returnChapter(chapter: _Chapter?) {
		self.dataStore?.setChapters(chapter: chapter)
	}
}
