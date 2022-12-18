//
//  NoteModels.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.12.2022.
//

import UIKit
import CoreTableView

enum Note {
    
    enum Request {
        case start
    }
    
    enum Response {
		case work(_Chapter?)
		case start
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
