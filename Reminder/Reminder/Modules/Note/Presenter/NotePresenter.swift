//
//  NotePresenter.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.12.2022.
//

import UIKit

protocol NotePresentationLogic: AnyObject {
    
}

final class NotePresenter: NotePresentationLogic {
    
	private weak var controller: NoteController?
    
    init(controller: NoteController? = nil) {
        self.controller = controller
    }
    
}
