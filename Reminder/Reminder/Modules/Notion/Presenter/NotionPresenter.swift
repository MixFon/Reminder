//
//  NotionPresenter.swift
//  Reminder
//
//  Created by Михаил Фокин on 21.12.2022.
//

import UIKit

protocol NotionPresentationLogic: AnyObject {
	func buildState(response: Notion.Response)
}

final class NotionPresenter: NotionPresentationLogic {
    
	private weak var controller: NotionController?
    
    init(controller: NotionController?) {
        self.controller = controller
    }
    
	func buildState(response: Notion.Response) {
		switch response {
		case .start:
			let show = Notion.ViewModel.Show()
			self.controller?.displayContent(show: .display(show))
		case .work(let text):
			let show = Notion.ViewModel.Show(
				text: text,
				title: "Заметка",
				heightView: calculateHeight(text: text ?? "", margin: 32),
				buttonTitle: "Добавить"
			)
			self.controller?.displayContent(show: .display(show))
		}
	}
	
	private func calculateHeight(text: String, margin: CGFloat) -> CGFloat {
		let leftMargin = 16.0
		let rightMargin = 16.0
		let topMargin = 45.0
		let bottomMargin = 74.0
		let finalWidth = UIScreen.main.bounds.width - leftMargin - rightMargin - margin * 2
		let titleSize = height(text: text, width: finalWidth, font: .systemFont(ofSize: 16.0))
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
