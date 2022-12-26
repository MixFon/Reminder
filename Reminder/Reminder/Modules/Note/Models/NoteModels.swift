//
//  NoteModels.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.12.2022.
//

import UIKit
import CoreTableView

protocol _Note {
	var title: String? { get set }
	var image: String? { get set }
}

struct DataNote: _Note {
	var title: String?
	var image: String?
}

enum Note {
    
    enum Request {
        case start
		case addNote
    }
    
    enum Response {
		case work(_Chapter?)
		case start
		case addNote
    }
    
    enum ViewModel {
        case display(NoteShow)
		case present
		
		struct Show: NoteShow {
			var title: String?
			var states: [State]?
		}
    }
}
