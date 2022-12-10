//
//  NoteModels.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.12.2022.
//

import UIKit

enum Note {
    
    enum Request {
        case start
    }
    
    enum Response {
		case start
    }
    
    enum ViewModel {
        case display(NoteShow)
    }
}
