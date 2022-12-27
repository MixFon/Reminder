//
//  NotionPresenter.swift
//  Reminder
//
//  Created by Михаил Фокин on 21.12.2022.
//

import UIKit

protocol NotionPresentationLogic: AnyObject {
	func buildState(response: NotionModel.Response)
}

final class NotionPresenter: NotionPresentationLogic {
    
	private weak var controller: NotionController?
    
    init(controller: NotionController?) {
        self.controller = controller
    }
    
	func buildState(response: NotionModel.Response) {
		switch response {
		case .start:
			let show = NotionModel.ViewModel.Show()
			self.controller?.displayContent(show: .display(show))
		case .work(let notion):
			let show = NotionModel.ViewModel.Show(
				text: notion?.text,
				title: notion?.title,
				heightView: calculateHeight(text: notion?.text ?? "", margin: 16),
				buttonTitle: notion?.buttonTitle
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


