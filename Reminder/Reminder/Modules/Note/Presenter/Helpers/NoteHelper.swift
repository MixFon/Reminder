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
	func editNote(note: _Note?)
	func changeIcon(note: _Note?)
	func deleteNote(note: _Note?)
}

final class NoteHelper: _TableHelper {
	
	private var actions: NoteActions?
	private var data: _Chapter?
	
	init(data: _Chapter? = nil, actions: NoteActions? = nil) {
		self.data = data
		self.actions = actions
	}
	
	func makeHeader() -> HeaderData? {
		return nil
	}
	
	enum CellAction {
		case edit
		case delete
		case chengeIcon
	}
	
	func makeElements() -> [Element] {
		var elements: [Element] = []
		for note in data?.notes ?? [] {
			let element = NoteView.ViewState.NoteCell(
				id: String(note.index ?? 0),
				title: note.text,
				image: UIImage(systemName: note.image?.getStingIcon() ?? "questionmark.circle.fill"),
				tintColor: note.image?.getColorIcon(),
				onAction: Command { action in
					switch action {
					case .delete:
						self.actions?.deleteNote(note: note)
					case .chengeIcon:
						self.actions?.changeIcon(note: note)
					case .edit:
						self.actions?.editNote(note: note)
					}
				}
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
