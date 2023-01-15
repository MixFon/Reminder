//
//  NoteModels.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.12.2022.
//

import UIKit
import CoreTableView


protocol _Note {
	var text: String? { get set }
	var image: IconNote? { get }
	var hachValue: Int? { get }
	
	mutating func changeIcon()
}

enum IconNote {
	case off
	case on
	
	init(isSelect: Bool?) {
		switch isSelect {
		case false:
			self = .off
		case true:
			self = .on
		default:
			self = .off
		}
	}
	
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
	
	func getBool() -> Bool {
		switch self {
		case .off:
			return false
		case .on:
			return true
		}
	}
}

enum NoteModel {
	
	struct Note: _Note {
		var text: String?
		var image: IconNote? = .off
		
		var hachValue: Int? {
			var hash = 0
			if let text {
				hash = [hash, text.hashValue].hashValue
			}
			if let image {
				hash = [hash, image.hashValue].hashValue
			}
			return hash
		}
		
		mutating func changeIcon() {
			self.image?.opositeImage()
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
