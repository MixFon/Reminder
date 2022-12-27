//
//  ReminderPresenter.swift
//  Reminder
//
//  Created by Михаил Фокин on 04.12.2022.
//

import UIKit

protocol ReminderPresentationLogic: AnyObject {
	func buildState(response: ReminderModel.Response)
}

final class ReminderPresenter: ReminderPresentationLogic {
    
    private weak var controller: ReminderDisplayLogic?
    
    init(controller: ReminderDisplayLogic? = nil) {
        self.controller = controller
    }
    
	func buildState(response: ReminderModel.Response) {
		switch response {
		case .start:
			let show = ReminderModel.ViewModel.Show()
			self.controller?.displayContent(show: .display(show))
		case .work(let chapters):
			let chapterHelper = ChapterHelper(chapters: chapters, actions: self)
			let state = chapterHelper.makeState()
			let show = ReminderModel.ViewModel.Show(states: [state])
			self.controller?.displayContent(show: .display(show))
		}
	}
}

extension ReminderPresenter: ChapterActions {
	
	func selectChapter(chapter: _Chapter) {
		self.controller?.displayContent(show: .present(chapter))
	}
}
