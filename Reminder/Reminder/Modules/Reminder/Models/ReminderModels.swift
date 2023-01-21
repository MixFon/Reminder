//
//  ReminderModels.swift
//  Reminder
//
//  Created by Михаил Фокин on 04.12.2022.
//

import UIKit
import CoreTableView

protocol _Chapter {
	var text: String? { get set }
	var notes: [_Note]? { get set }
	
	func addNote(note: _Note?)
	func deleteNote(note: _Note?)
	
	/// Устанавливает все ячейки в состояние неактина
	func cleanAllNotes()
}

enum ReminderModel {
	
    enum Request {
		case add
		case edit(_Chapter?)
		case start
		case delete(_Chapter?)
		case selectChapter(_Chapter?)
    }
    
    enum Response {
		case start
		case work([_Chapter]?)
    }
    
	enum ViewModel {
		case display(ReminderShow)
		case edit(_Chapter?)
		case delete(_Chapter?)
		case present(_Chapter?)
		
		struct Show: ReminderShow {
			var title: String?
			var states: [State]?
		}
    }
}
