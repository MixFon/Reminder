//
//  NotePresenter.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.12.2022.
//

import UIKit

protocol NotePresentationLogic: AnyObject {
	func buildState(response: Note.Response)
}

final class NotePresenter: NotePresentationLogic {
    
	private weak var controller: NoteController?
    
    init(controller: NoteController? = nil) {
        self.controller = controller
    }
    
	func buildState(response: Note.Response) {
		switch response {
		case .start:
			let show = Note.ViewModel.Show()
			self.controller?.displayContent(show: .display(show))
		case .work(let chapter):
			let helper = NoteHelper(data: chapter, actions: self)
			let show = Note.ViewModel.Show(
				title: chapter?.chapter,
				states: [helper.makeState()]
			)
			self.controller?.displayContent(show: .display(show))
		}
	}
}

extension NotePresenter: NoteActions {
	
}
