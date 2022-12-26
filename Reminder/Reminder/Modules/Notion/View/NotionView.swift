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
	var topConstraint: CGFloat? { get }
}

protocol NotionViewAction: AnyObject{
	func textChenge(text: String?)
}

final class NotionView: UIView {

	@IBOutlet private weak var title: UILabel!
	@IBOutlet private weak var textView: UITextView!
	@IBOutlet private weak var mainView: UIView!
	@IBOutlet private weak var addButton: UIButton!
	@IBOutlet private weak var heightView: NSLayoutConstraint!
	@IBOutlet private weak var topConstraint: NSLayoutConstraint!
	
	weak var delegate: NotionViewAction?
	private var startTopConstraint: CGFloat = 20.0
	
	override func awakeFromNib() {
		self.textView.delegate = self
		self.textView.layer.cornerRadius = 8
		self.mainView.layer.cornerRadius = 16
		self.addButton.layer.cornerRadius = 25
	}
	
	struct ViewState {
		
	}
	
	func setNotification() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
		self.addGestureRecognizer(tapGesture)
		
		// Open & Close Keyboard Notifications
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(self.keyboardWillShow),
			name: UIResponder.keyboardWillShowNotification,
			object: nil
		)

		NotificationCenter.default.addObserver(
			self,
			selector: #selector(self.keyboardWillHide),
			name: UIResponder.keyboardWillHideNotification,
			object: nil
		)
	}
	
	@objc private func keyboardWillShow(_ notification: Notification) {
		let userInfo = notification.userInfo
		guard let endFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
		debugPrint(endFrame, endFrame.minY, endFrame.maxY)
		debugPrint(self.mainView.frame, self.mainView.frame.minY, self.mainView.frame.maxY)
		let dy = endFrame.minY - self.mainView.frame.maxY
		let dx = dy - 72
		debugPrint(dy, dx, self.topConstraint.constant, self.heightView.constant)
		setTopConstrains(constraint: self.topConstraint.constant + dx)
	}
	
	@objc private func keyboardWillHide() {
		setTopConstrains(constraint: self.startTopConstraint)
	}
	
	private func setTopConstrains(constraint: CGFloat?) {
		guard let constraint else { return }
		DispatchQueue.main.async {
			UIView.animate(
				withDuration: 0.8,
				delay: 0,
				usingSpringWithDamping: 0.8,
				initialSpringVelocity: 0,
				options: .curveEaseInOut,
				animations: {
					self.topConstraint.constant = constraint
					self.layoutIfNeeded()
				}
			)
		}
	}
	
	
	private func updateTopConstraint(heightView: CGFloat?) {
		guard let heightView else { return }
		if self.heightView.constant != heightView {
			let constraint = self.topConstraint.constant - (heightView - self.heightView.constant)
			if constraint > self.startTopConstraint {
				self.topConstraint.constant = constraint
				self.heightView.constant = heightView
			}
		}
	}


	func configure(with data: NotionShow?) {
		if let data {
			self.title.text = data.title
			self.textView.text = data.text
			self.addButton.setTitle(data.buttonTitle, for: .normal)
			updateTopConstraint(heightView: data.heightView)
		}
	}
}

extension NotionView: UITextViewDelegate {
	
	func textViewDidChange(_ textView: UITextView) {
		self.delegate?.textChenge(text: textView.text)
	}
}
