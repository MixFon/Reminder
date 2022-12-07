//
//  NoteCell.swift
//  Reminder
//
//  Created by Михаил Фокин on 07.12.2022.
//

import UIKit
import CoreExtensions

protocol _NoteCell {
	var title: String? { get }
}

final class NoteCell: UITableViewCell {

	@IBOutlet private weak var title: UILabel!
	@IBOutlet private weak var backgroundCell: UIView!
	
	override func awakeFromNib() {
        super.awakeFromNib()
		self.backgroundCell.roundCorners(.all, radius: 10)
    }

	func configure(with data: _NoteCell) {
		self.title.text = data.title
	}
    
}
