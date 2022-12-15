//
//  NoteRouter.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.12.2022.
//

import UIKit

protocol NoteRoutingLogic {
    
}

protocol NoteDataPassing {
  var dataStore: NoteDataStore? { get set }
}

final class NoteRouter: NoteRoutingLogic, NoteDataPassing {
	
	private weak var controller: NoteController?
	var dataStore: NoteDataStore?
	
	init(controller: NoteController? = nil) {
		self.controller = controller
	}
	
}
