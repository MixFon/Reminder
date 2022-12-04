//
//  ReminderInteractor.swift
//  Reminder
//
//  Created by Михаил Фокин on 04.12.2022.
//

import Foundation

protocol ReminderBusinessLogic: AnyObject {
    
}

final class ReminderInteractor: ReminderBusinessLogic {
    
    private var presenter: ReminderPresentationLogic?
    
    init(presenter: ReminderPresentationLogic? = nil) {
        self.presenter = presenter
    }
    
}
