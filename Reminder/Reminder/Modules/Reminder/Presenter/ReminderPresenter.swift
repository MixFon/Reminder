//
//  ReminderPresenter.swift
//  Reminder
//
//  Created by Михаил Фокин on 04.12.2022.
//

import UIKit

protocol ReminderPresentationLogic: AnyObject {
	func buildState(response: Reminder.Response)
}

final class ReminderPresenter: ReminderPresentationLogic {
    
    private weak var controller: ReminderDisplayLogic?
    
    init(controller: ReminderDisplayLogic?) {
        self.controller = controller
    }
    
	func buildState(response: Reminder.Response) {
		switch response {
		case .start:
			let show = Reminder.ViewModel.Show()
			self.controller?.displayState(show: .display(show))
		case .work(let chapters):
			let chapterHelper = ChapterHelper(chapters: chapters, controller: self.controller)
			let state = chapterHelper.makeState()
			let show = Reminder.ViewModel.Show(states: [state])
			self.controller?.displayState(show: .display(show))
		}
	}
}
