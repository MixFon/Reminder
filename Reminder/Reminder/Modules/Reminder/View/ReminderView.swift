//
//  ReminderView.swift
//  Reminder
//
//  Created by Михаил Фокин on 04.12.2022.
//

import UIKit
import CoreTableView

protocol ReminderShow {
	var states: [State]? { get }
}

final class ReminderView: UIView {
	
	@IBOutlet weak var table: BaseTableView!
	
	struct ViewState {
		
	}
	
	func configure(with data: ReminderShow?) {
		if let states = data?.states {
			self.table.viewStateInput = states
		}
	}
}
