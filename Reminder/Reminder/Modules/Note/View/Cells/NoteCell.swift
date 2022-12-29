//
//  NoteCell.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.12.2022.
//

import UIKit
import CoreTableView
import CoreExtensions

protocol _NoteCell: CellData {
	var title: String? { get }
	var image: UIImage? { get }
	var tintColor: UIColor? { get }
	var onAction: Command<NoteHelper.CellAction>? { get }
}

extension _NoteCell {
	
	public var height: CGFloat { return calculateHeight(text: self.title ?? "", hasAccesory: false, margin: 32) }
	
	public func hashValues() -> [Int] {
		return [
			self.id.hashValue,
			self.title.hashValue,
			self.image.hashValue,
			self.tintColor.hashValue
		]
	}
	
	public var backgroundColor: UIColor? { return nil }
	
	public func prepare(cell: UITableViewCell, for tableView: UITableView, indexPath: IndexPath) {
		guard let cell = cell as? NoteCell else { return }
		cell.configure(with: self)
	}
	
	public func cell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
		tableView.register(NoteCell.nib(), forCellReuseIdentifier: NoteCell.identifire)
		return tableView.dequeueReusableCell(withIdentifier: NoteCell.identifire, for: indexPath) as? NoteCell ?? .init()
	}
	
	private func calculateHeight(text: String, hasAccesory: Bool, margin: CGFloat) -> CGFloat {
		let leftMargin = 55.0
		let rightMargin = 16.0
		let topMargin = 24.0
		let bottomMargin = 24.0
		let finalWidth = UIScreen.main.bounds.width - leftMargin - rightMargin - margin
		let titleSize = height(text: text, width: finalWidth, font: UIFont.systemFont(ofSize: 14))
		return topMargin + titleSize + bottomMargin
	}
	
	private func height(text: String, width: CGFloat, font: UIFont) -> CGFloat {
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = text.boundingRect(
			with: constraintRect,
			options: .usesLineFragmentOrigin,
			attributes: [NSAttributedString.Key.font: font],
			context: nil
		)
		return ceil(boundingBox.height)
	}
}

final class NoteCell: UITableViewCell {
	
	@IBOutlet private weak var title: UILabel!
	@IBOutlet private weak var leftImage: UIImageView!
	@IBOutlet private weak var backgroundCell: UIView!
	
	private var onAction: Command<NoteHelper.CellAction>?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.selectionStyle = .none
		
		let interaction = UIContextMenuInteraction(delegate: self)
		self.backgroundCell.addInteraction(interaction)
		
		let gesturePress = UITapGestureRecognizer(target: self, action:  #selector(self.checkActionPress))
		self.backgroundCell.addGestureRecognizer(gesturePress)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		self.backgroundCell.layer.cornerRadius = 16
	}
	
	@objc func checkActionPress(sender : UILongPressGestureRecognizer) {
		self.onAction?.perform(with: .chengeIcon)
	}
	
	func configure(with data: _NoteCell) {
		self.title.text = data.title
		self.leftImage.tintColor = data.tintColor
		self.leftImage.image = data.image
		self.onAction = data.onAction
	}
}

extension NoteCell: UIContextMenuInteractionDelegate {
	
	func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
		let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
			let edit = UIAction(
				title: "Редактировать",
				image: UIImage(systemName: "square.and.pencil"),
				handler: { action in
					self.onAction?.perform(with: .edit)
				}
			)

			let delete = UIAction(
				title: "Удалить",
				image: UIImage(systemName: "trash"),
				attributes: .destructive,
				handler: { action in
					self.onAction?.perform(with: .delete)
				}
			)
			return UIMenu(title: "Выбирете действие", children: [edit, delete])
		}
		return configuration
	}
}
