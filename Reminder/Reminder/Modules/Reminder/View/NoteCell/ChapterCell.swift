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
}

extension _ChapterCell {
	
	public var height: CGFloat { return 76 }
	
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
	
	override func awakeFromNib() {
        super.awakeFromNib()
		self.backgroundCell.roundCorners(.all, radius: 10)
    }

	func configure(with data: _ChapterCell) {
		self.title.text = data.title
	}
}
