//
//  NotionModels.swift
//  Reminder
//
//  Created by Михаил Фокин on 21.12.2022.
//

import UIKit

enum Notion {
    
    enum Request {
		case work
		case start
		case selectNote(_Note?)
    }
    
    enum Response {
		case work(_Note?)
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
		}
    }
}
