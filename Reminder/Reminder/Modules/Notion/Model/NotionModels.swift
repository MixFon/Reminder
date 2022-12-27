//
//  NotionModels.swift
//  Reminder
//
//  Created by Михаил Фокин on 21.12.2022.
//

import UIKit

protocol _Notion {
	var text: String? { get set }
	var title: String? { get }
	var buttonTitle: String? { get }
}


enum NotionModel {
	
	struct Notion: _Notion {
		var text: String?
		var title: String?
		var buttonTitle: String?
	}
	
	enum Request {
		case work
		case start
		case changeText(String?)
		case selectNotion(_Notion?)
    }
    
    enum Response {
		case work(_Notion?)
		case start
    }
    
    enum ViewModel {
		case display(NotionShow?)
		case present
		
		struct Show: NotionShow {
			var text: String?
			var title: String?
			var heightView: CGFloat?
			var buttonTitle: String?
			var topConstraint: CGFloat?
		}
    }
}
