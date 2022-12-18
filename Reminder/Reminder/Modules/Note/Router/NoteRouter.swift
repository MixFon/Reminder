//
//  NoteRouter.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.12.2022.
//

import UIKit

protocol NoteRoutingLogic {
	func presentController()
}

protocol NoteDataPassing {
  var dataStore: NoteDataStore? { get set }
}

protocol NoteDataReturn {
	
}

final class NoteRouter: NoteRoutingLogic, NoteDataPassing {
	
	private weak var controller: NoteController?
	var dataStore: NoteDataStore?
	
	init(controller: NoteController? = nil) {
		self.controller = controller
	}
	
	func presentController() {
		
	}
}

extension NoteRouter: NoteDataReturn {
	
}
