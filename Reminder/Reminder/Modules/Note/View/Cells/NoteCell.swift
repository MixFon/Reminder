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

}

extension _NoteCell {
	
	public var height: CGFloat { return 76 }
	
	public func hashValues() -> [Int] {
		return [
			
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

	override func awakeFromNib() {
		super.awakeFromNib()
	}

	func configure(with data: _NoteCell) {
		
	}
}
