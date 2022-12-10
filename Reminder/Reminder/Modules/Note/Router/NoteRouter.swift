//
//  NoteRouter.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.12.2022.
//

import UIKit

protocol NoteRoutingLogic {
    
}

final class NoteRouter: NoteRoutingLogic {
  
    weak var controller: NoteController?
  
    init(controller: NoteController? = nil) {
        self.controller = controller
    }

}
