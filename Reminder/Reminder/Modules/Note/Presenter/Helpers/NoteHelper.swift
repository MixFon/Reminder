//
//  NoteHelper.swift
//  Reminder
//
//  Created by Михаил Фокин on 17.12.2022.
//

import UIKit
import Foundation
import CoreTableView

protocol NoteActions {
	
}

final class NoteHelper: _TableHelper {
	
	private var actions: NoteActions?
	private var data: _Chapter?
	
	init(data: Any? = nil, actions: NoteActions? = nil) {
		self.data = data as? _Chapter
		self.actions = actions
	}
	
	func makeHeader() -> HeaderData? {
		return nil
	}
	
	func makeElements() -> [Element] {
		var elements: [Element] = []
		for note in data?.notes ?? [] {
			let element = NoteView.ViewState.NoteCell(
				id: note,
				title: note,
				image: UIImage(systemName: "note.text"),
				tintColor: .Green
			)
			elements.append(element.toElement())
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
			id: "NoteDataSection",
			isCollapsed: false,
			header: makeHeader(),
			footer: makeFooter()
		)
		return section
	}
}
