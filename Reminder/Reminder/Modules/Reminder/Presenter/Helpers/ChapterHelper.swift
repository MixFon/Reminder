//
//  ChapterHelper.swift
//  Reminder
//
//  Created by Михаил Фокин on 11.12.2022.
//

import Foundation
import CoreTableView

protocol ChapterActions {
	func editChapter(chapter: _Chapter)
	func deleteChapter(chapter: _Chapter)
	func selectChapter(chapter: _Chapter)
}

final class ChapterHelper: _TableHelper {
	
	private var chapters: [_Chapter]?
	private var actions: ChapterActions?
	
	enum CellAction {
		case edit
		case delete
		case select
	}
	
	init(chapters: [_Chapter]? = nil, actions: ChapterActions? = nil) {
		self.chapters = chapters
		self.actions = actions
	}
	
	func makeHeader() -> HeaderData? {
		return nil
	}
	
	func makeElements() -> [Element] {
		var elements: [Element] = []
		for chapter in self.chapters ?? [] {
			let dataChapters = ReminderView.ViewState.Chapter(
				id: "\(chapter.hashValue)",
				title: chapter.text,
				onAction: Command { action in
					switch action {
					case .edit:
						self.actions?.editChapter(chapter: chapter)
					case .delete:
						self.actions?.deleteChapter(chapter: chapter)
					case .select:
						self.actions?.selectChapter(chapter: chapter)
					}
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
