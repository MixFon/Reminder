//
//  NoteModels.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.12.2022.
//

import UIKit
import CoreTableView


protocol _Note {
	typealias NoteIndex = Range<Array<_Note>.Index>.Element
	var text: String? { get set }
	var index: NoteIndex? { get set }
	var image: IconNote? { get set }
	var hachValue: Int? { get }
}

enum IconNote {
	case off
	case on
	
	mutating func opositeImage() {
		switch self {
		case .off:
			self = .on
		case .on:
			self = .off
		}
	}
	
	func getStingIcon() -> String {
		switch self {
		case .off:
			return "minus.circle.fill"
		case .on:
			return "checkmark.circle.fill"
		}
	}
	
	func getColorIcon() -> UIColor {
		switch self {
		case .off:
			return .Danger
		case .on:
			return .Green
		}
	}
}

enum NoteModel {
	
	struct Note: _Note {
		var text: String?
		var index: NoteIndex?
		var image: IconNote? = .off
		
		var hachValue: Int? {
			var hash = 0
			if let text {
				hash = [hash, text.hashValue].hashValue
			}
			if let index {
				hash = [hash, index.hashValue].hashValue
			}
			if let image {
				hash = [hash, image.hashValue].hashValue
			}
			return hash
		}
	}
    
    enum Request {
		case add
		case edit(_Note?)
        case start
		case delete(_Note?)
		case changeIcon(_Note?)
    }
    
    enum Response {
		case work(_Chapter?)
		case start
    }
    
    enum ViewModel {
		case edit(_Note?)
		case delete(_Note?)
        case display(NoteShow)
		case changeIcon(_Note?)
		case presentNotion
		
		struct Show: NoteShow {
			var title: String?
			var states: [State]?
		}
    }
}
