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

protocol NoteViewAction: AnyObject{
	func addNote()
	func closeView()
}

final class NoteView: UIView {

	@IBOutlet weak var table: BaseTableView!
	@IBOutlet weak var navigationBar: UINavigationBar!
	@IBOutlet weak var navagationTitle: UINavigationItem!
	
	weak var delegate: NoteViewAction?
	
	struct ViewState {
		
		struct NoteCell: _NoteCell {
			var id: String
			var title: String?
			var image: UIImage?
			var tintColor: UIColor?
			var onAction: Command<NoteHelper.CellAction>?
		}
	}
	
	@IBAction func pressBack(_ sender: UIBarButtonItem) {
		self.delegate?.closeView()
	}
	
	@IBAction func pressAdd(_ sender: UIBarButtonItem) {
		self.delegate?.addNote()
	}
	
	func configure(with data: NoteShow) {
		if let states = data.states {
			self.table.viewStateInput = states
		}
		self.navagationTitle.title = data.title
	}
	
}
