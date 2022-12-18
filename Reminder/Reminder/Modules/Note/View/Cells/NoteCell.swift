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
}

extension _NoteCell {
	
	public var height: CGFloat { return 76 }
	
	public func hashValues() -> [Int] {
		return [
			self.title.hashValue,
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
}

final class NoteCell: UITableViewCell {

	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var leftImage: UIImageView!
	@IBOutlet weak var backgroundCell: UIView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.selectionStyle = .none
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		self.backgroundCell.layer.cornerRadius = 16
	}

	func configure(with data: _NoteCell) {
		self.title.text = data.title
		self.leftImage.tintColor = data.tintColor
		self.leftImage.image = data.image
	}
}
