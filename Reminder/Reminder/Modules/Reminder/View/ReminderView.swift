//
//  ReminderView.swift
//  Reminder
//
//  Created by Михаил Фокин on 04.12.2022.
//

import UIKit
import CoreTableView

protocol ReminderShow {
	var title: String? { get }
	var states: [State]? { get }
}

protocol ReminderViewAction: AnyObject{
	func addNewChapter()
}

final class ReminderView: UIView {
	
	@IBOutlet private weak var table: BaseTableView!
	@IBOutlet private weak var title: UINavigationItem!
	
	weak var delegate: ReminderViewAction?
	
	@IBAction func pressAdd(_ sender: UIBarButtonItem) {
		self.delegate?.addNewChapter()
	}
	
	struct ViewState {
		
		struct Chapter: _ChapterCell {
			var id: String
			var title: String?
			var onAction: Command<ChapterHelper.CellAction>?
		}
	}
	
	func configure(with data: ReminderShow?) {
		if let states = data?.states {
			self.table.viewStateInput = states
			self.title.title = data?.title
		}
	}
}
