//
//  ReminderModels.swift
//  Reminder
//
//  Created by Михаил Фокин on 04.12.2022.
//

import UIKit
import CoreTableView

protocol _Chapter {
	var notes: [String]? { get }
	var chapter: String? { get }
}

enum Reminder {
    
    enum Request {
		case start
    }
    
    enum Response {
		case start
		case work([_Chapter])
		
		struct Chapter: _Chapter {
			var notes: [String]?
			var chapter: String?
		}
    }
    
	enum ViewModel {
		case display(ReminderShow)
		case present
		
		struct Show: ReminderShow {
			var states: [State]?
		}
    }
}
