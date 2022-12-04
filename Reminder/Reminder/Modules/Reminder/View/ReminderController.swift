//
//  ReminderController.swift
//  Reminder
//
//  Created by Михаил Фокин on 04.12.2022.
//

import UIKit
import CoreExtensions

protocol ReminderDisplayLogic: AnyObject {
    
}

final class ReminderController: UIViewController {
    
	private let reminderView = ReminderView.loadFromNib()
    private var interactor: ReminderBusinessLogic?
	private var router: ReminderRoutingLogic?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "ReminderController", bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        let presenter = ReminderPresenter(controller: self)
        let interactor = ReminderInteractor(presenter: presenter)
        let router = ReminderRouter(controller: self)
        self.interactor = interactor
        self.router = router
    }
    
	
	override func viewDidLoad() {
		self.view = self.reminderView
		self.reminderView.configure(with: nil)
	}
	
	func mekeState() {
		
	}
    
}

extension ReminderController: ReminderDisplayLogic {
    
}
