//
//  ChapterCell.swift
//  Reminder
//
//  Created by Михаил Фокин on 07.12.2022.
//

import UIKit
import CoreTableView
import CoreExtensions

protocol _ChapterCell: CellData {
	var title: String? { get }
	var onAction: Command<ChapterHelper.CellAction>? { get }
}

extension _ChapterCell {
	
	public var height: CGFloat { return 79 }
	
	public func hashValues() -> [Int] {
		return [
			self.title.hashValue
		]
	}
	
	public var backgroundColor: UIColor? { return nil }
	
	public func prepare(cell: UITableViewCell, for tableView: UITableView, indexPath: IndexPath) {
		guard let cell = cell as? ChapterCell else { return }
		cell.configure(with: self)
	}
	
	public func cell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
		tableView.register(ChapterCell.nib(), forCellReuseIdentifier: ChapterCell.identifire)
		return tableView.dequeueReusableCell(withIdentifier: ChapterCell.identifire, for: indexPath) as? ChapterCell ?? .init()
	}
}

final class ChapterCell: UITableViewCell {

	@IBOutlet private weak var title: UILabel!
	@IBOutlet private weak var backgroundCell: UIView!
	
	private var onAction: Command<ChapterHelper.CellAction>?
	
	override func awakeFromNib() {
        super.awakeFromNib()
		self.selectionStyle = .none
		
		let interaction = UIContextMenuInteraction(delegate: self)
		self.backgroundCell.addInteraction(interaction)
		
		let gesturePress = UITapGestureRecognizer(target: self, action:  #selector(self.checkActionPress))
		self.backgroundCell.addGestureRecognizer(gesturePress)
    }
	
	@objc func checkActionPress(sender : UILongPressGestureRecognizer) {
		self.onAction?.perform(with: .select)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		self.backgroundCell.layer.cornerRadius = 10
	}

	func configure(with data: _ChapterCell) {
		self.title.text = data.title
		self.onAction = data.onAction
	}
}

extension ChapterCell: UIContextMenuInteractionDelegate {
	
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
