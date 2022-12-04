//
//  ReminderPresenter.swift
//  Reminder
//
//  Created by Михаил Фокин on 04.12.2022.
//

import UIKit

protocol ReminderPresentationLogic: AnyObject {
    
}

final class ReminderPresenter: ReminderPresentationLogic {
    
    private weak var controller: ReminderDisplayLogic?
    
    init(controller: ReminderDisplayLogic? = nil) {
        self.controller = controller
    }
    
}
