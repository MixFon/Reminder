//
//  ReminderRouter.swift
//  Reminder
//
//  Created by Михаил Фокин on 04.12.2022.
//

import UIKit

protocol ReminderRoutingLogic {
	func presentNoteController()
}

protocol ReminderDataPassing {
  var dataStore: ReminderDataStore? { get }
}

final class ReminderRouter: ReminderRoutingLogic, ReminderDataPassing {
  
    private weak var controller: ReminderController?
	var dataStore: ReminderDataStore?
  
    init(controller: ReminderController?) {
        self.controller = controller
    }
	
	func presentNoteController() {
		
	}

}
