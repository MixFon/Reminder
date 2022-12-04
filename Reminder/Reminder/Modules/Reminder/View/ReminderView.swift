//
//  ReminderView.swift
//  Reminder
//
//  Created by Михаил Фокин on 04.12.2022.
//

import UIKit
import CoreTableView

protocol _ReminderView {
	
}

final class ReminderView: UIView {
	
	@IBOutlet weak var table: BaseTableView!
	
	func configure(with data: _ReminderView?) {
		self.table.backgroundColor = .red
	}
}
