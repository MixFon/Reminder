//
//  NotificationCell.swift
//  Reminder
//
//  Created by Михаил Фокин on 23.01.2023.
//

import UIKit
import CoreTableView
import CoreExtensions

protocol _NotificationCell: CellData {
	var title: String? { get }
	var image: UIImage? { get }
}

extension _NotificationCell {
	
	public var height: CGFloat { return calculateHeight(text: self.title ?? "", margin: 32) }
	
	public func hashValues() -> [Int] {
		return [
			self.title.hashValue,
			self.image.hashValue
		]
	}
	
	public var backgroundColor: UIColor? { return nil }
	
	public func prepare(cell: UITableViewCell, for tableView: UITableView, indexPath: IndexPath) {
		guard let cell = cell as? NotificationCell else { return }
		cell.configure(with: self)
	}
	
	public func cell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
		tableView.register(NotificationCell.nib(), forCellReuseIdentifier: NotificationCell.identifire)
		return tableView.dequeueReusableCell(withIdentifier: NotificationCell.identifire, for: indexPath) as? NotificationCell ?? .init()
	}
	
	private func calculateHeight(text: String, margin: CGFloat) -> CGFloat {
			let leftMargin = 16.0
			let rightMargin = 16.0
			let topMargin = 91.0
			let bottomMargin = 16.0
			let finalWidth = UIScreen.main.bounds.width - leftMargin - rightMargin - margin * 2
			let titleSize = heightUITextField(text: text, width: finalWidth, font: .systemFont(ofSize: 16.0))
			return topMargin + titleSize + bottomMargin
		}
		
		private func heightUITextField(text: String, width: CGFloat, font: UIFont) -> CGFloat {
			let textField = UITextView(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
			textField.text = text
			textField.font = font
			textField.sizeToFit()
			return textField.frame.height
		}
}

final class NotificationCell: UITableViewCell {

	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var mainImage: UIImageView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.isSelected = false
	}

	func configure(with data: _NotificationCell) {
		self.title.text = data.title
		self.mainImage.image = data.image
	}
}
