//
//  ReminderRouter.swift
//  Reminder
//
//  Created by Михаил Фокин on 04.12.2022.
//

import UIKit

protocol ReminderRoutingLogic {
    
}

final class ReminderRouter: ReminderRoutingLogic {
  
    private weak var controller: ReminderController?
  
    init(controller: ReminderController?) {
        self.controller = controller
    }

}
