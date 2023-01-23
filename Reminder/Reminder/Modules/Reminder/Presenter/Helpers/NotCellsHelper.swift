//
//  NotCapterHelper.swift
//  Reminder
//
//  Created by Михаил Фокин on 23.01.2023.
//

import UIKit
import Foundation
import CoreTableView

protocol NotCapterActions {
	
}

final class NotCellsHelper: _TableHelper {
	
	private var data: String
	private var actions: NotCapterActions?
	
	init(data: String, actions: NotCapterActions? = nil) {
		self.data = data
		self.actions = actions
	}
	
	func makeHeader() -> HeaderData? {
		return nil
	}
	
	func makeElements() -> [Element] {
		var elements: [Element] = []
		let element = ReminderView.ViewState.Notification(
			id: "NotCellsHelper",
			title: self.data,
			image: UIImage(systemName: "text.magnifyingglass")
		)
		elements.append(element.toElement())
		return elements
	}
	
	func makeFooter() -> FooterData? {
		return nil
	}
	
	func makeState() -> State {
		let elements = makeElements()
		let section = makeSection()
		let state = State(model: section, elements: elements)
		return state
	}
	
	func makeSection() -> SectionState {
		let section = SectionState(
			id: "NotCellsDataSection",
			isCollapsed: false,
			header: makeHeader(),
			footer: makeFooter()
		)
		return section
	}
}
