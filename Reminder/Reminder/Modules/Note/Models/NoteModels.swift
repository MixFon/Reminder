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
	
	/// Меняет значение иконки на противоположное
	func changeIcon()
	
	/// Сброс до состояния не активна
	func cleanIcon()
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
}

enum NoteModel {
    
    enum Request {
		case add
		case edit(_Note?)
		case clean
        case start
		case delete(_Note?)
		case changeIcon(_Note?)
    }
    
    enum Response {
		case work(_Chapter?)
		case start
		case notCells(_Chapter?)
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
