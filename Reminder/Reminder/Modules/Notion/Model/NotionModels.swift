//
//  NotionModels.swift
//  Reminder
//
//  Created by Михаил Фокин on 21.12.2022.
//

import UIKit

enum Notion {
    
    enum Request {
		case start
		case work(String?)
    }
    
    enum Response {
		case work(String?)
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
