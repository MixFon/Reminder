//
//  ChapterHelper.swift
//  Reminder
//
//  Created by Михаил Фокин on 11.12.2022.
//

import Foundation
import CoreTableView

final class ChapterHelper: _TableHelper {
	
	func makeHeader() -> HeaderData? {
		return nil
	}
	
	func makeElements() -> [Element] {
		return []
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
			id: "ChapterDataSection",
			isCollapsed: false,
			header: makeHeader(),
			footer: makeFooter()
		)
		return section
	}
}
