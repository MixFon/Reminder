//
//  ChapterHelper.swift
//  Reminder
//
//  Created by Михаил Фокин on 11.12.2022.
//

import Foundation
import CoreTableView

final class ChapterHelper: _TableHelper {
	
	private var chapters: [_Chapter]?
	private var controller: ReminderDisplayLogic?
	
	init(chapters: [_Chapter]?, controller: ReminderDisplayLogic?) {
		self.chapters = chapters
		self.controller = controller
	}
	
	func makeHeader() -> HeaderData? {
		return nil
	}
	
	func makeElements() -> [Element] {
		var elements: [Element] = []
		for chapter in self.chapters ?? [] {
			let dataChapters = ReminderView.ViewState.Chapter(
				id: chapter.chapter ?? "",
				title: chapter.chapter,
				onItemSelect: Command { [weak self] in
					guard let self else { return }
					self.controller?.displayState(show: .present)
				}
			)
			elements.append(dataChapters.toElement())
		}
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
			id: "ChapterDataSection",
			isCollapsed: false,
			header: makeHeader(),
			footer: makeFooter()
		)
		return section
	}
}
