//
//  NoteView.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.12.2022.
//

import UIKit
import CoreTableView

protocol NoteShow {
	var title: String? { get }
	var states: [State]? { get }
}

final class NoteView: UIView {

	@IBOutlet weak var table: BaseTableView!
	
	struct ViewState {
		
		struct NoteCell: _NoteCell {
			var id: String
			var title: String?
			var image: UIImage?
			var tintColor: UIColor?
		}
	}
	
	func configure(with data: NoteShow) {
		if let states = data.states {
			self.table.viewStateInput = states
		}
	}
	
}
