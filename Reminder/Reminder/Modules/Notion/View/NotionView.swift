//
//  NotionView.swift
//  Reminder
//
//  Created by Михаил Фокин on 21.12.2022.
//

import UIKit

protocol NotionShow {
	var text: String? { get }
	var title: String? { get }
	var heightView: CGFloat? { get }
	var buttonTitle: String? { get }
}

final class NotionView: UIView {

	@IBOutlet private weak var title: UILabel!
	@IBOutlet private weak var textView: UITextView!
	@IBOutlet private weak var addButton: UIButton!
	
	@IBOutlet weak var heightView: NSLayoutConstraint!
	
	override func awakeFromNib() {
		self.textView.layer.cornerRadius = 8
		self.addButton.layer.cornerRadius = 25

	}
	
	struct ViewState {
		
	}

	func configure(with data: NotionShow?) {
		if let data {
			self.title.text = data.title
			self.textView.text = data.text
			self.addButton.setTitle(data.title, for: .normal)
			self.heightView.constant = data.heightView ?? 0
		}
	}
	
}
