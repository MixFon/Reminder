//
//  ReminderRouter.swift
//  Reminder
//
//  Created by Михаил Фокин on 04.12.2022.
//

import UIKit

protocol ReminderRoutingLogic {
	func presentNotionController()
	func presentController()
}

final class ReminderRouter: ReminderRoutingLogic {
  
    private weak var controller: ReminderController?
	var dataStore: (ReminderDataStore & NotionPipe & NotePipe)?
  
    init(controller: ReminderController? = nil) {
        self.controller = controller
    }
	
	func presentController() {
		let noteController = NoteController()
		noteController.modalPresentationStyle = .fullScreen
		noteController.setPipe(pipe: self.dataStore)
		self.controller?.present(noteController, animated: true)
	}
	
	func presentNotionController() {
		let notion = NotionController()
		notion.modalPresentationStyle = .popover
		notion.setPipe(pipe: self.dataStore)
		self.controller?.present(notion, animated: true)
	}
}

