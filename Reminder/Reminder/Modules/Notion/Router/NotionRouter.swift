//
//  NotionRouter.swift
//  Reminder
//
//  Created by Михаил Фокин on 21.12.2022.
//

import UIKit

protocol NotionRoutingLogic {
	func presentController()
}

protocol NotionDataPassing {
	var dataStore: NotionDataStore? { get set }
}

protocol NotionDataReturn {
	
}

final class NotionRouter: NotionRoutingLogic, NotionDataPassing {
	
	private weak var controller: NotionController?
	
	var dataStore: NotionDataStore?
	
	init(controller: NotionController? = nil) {
		self.controller = controller
	}
	
	func presentController() {
		
	}
	
}

extension NotionRouter: NotionDataReturn {
	
}
