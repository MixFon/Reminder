//
//  NotePresenter.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.12.2022.
//

import UIKit

protocol NotePresentationLogic: AnyObject {
	func buildState(response: NoteModel.Response)
}

final class NotePresenter: NotePresentationLogic {
    
	private weak var controller: NoteController?
    
    init(controller: NoteController? = nil) {
        self.controller = controller
    }
    
	func buildState(response: NoteModel.Response) {
		switch response {
		case .start:
			let show = NoteModel.ViewModel.Show()
			self.controller?.displayContent(show: .display(show))
		case .work(let chapter):
			let helper = NoteHelper(data: chapter, actions: self)
			let show = NoteModel.ViewModel.Show(
				title: chapter?.text,
				states: [helper.makeState()]
			)
			self.controller?.displayContent(show: .display(show))
		}
	}
}

extension NotePresenter: NoteActions {
	func editNote(note: _Note?) {
		self.controller?.displayContent(show: .edit(note))
	}
	
	func changeIcon(note: _Note?) {
		self.controller?.displayContent(show: .changeIcon(note))
	}
	
	func deleteNote(note: _Note?) {
		self.controller?.displayContent(show: .delete(note))
	}
	
}
