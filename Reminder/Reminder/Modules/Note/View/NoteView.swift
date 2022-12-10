//
//  NoteView.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.12.2022.
//

import UIKit
import CoreTableView

protocol NoteShow {
	var states: [State]? { get }
}

final class NoteView: UIView {

	@IBOutlet weak var table: BaseTableView!
	
	struct ViewState {
		
	}
	
	func configure(with data: NoteShow) {
		if let states = data.states {
			self.table.viewStateInput = states
		}
	}
	
}
