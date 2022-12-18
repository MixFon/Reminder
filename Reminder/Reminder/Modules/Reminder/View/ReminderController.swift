//
//  ReminderController.swift
//  Reminder
//
//  Created by Михаил Фокин on 04.12.2022.
//

import UIKit
import CoreExtensions

protocol ReminderDisplayLogic: AnyObject {
	func displayContent(show: Reminder.ViewModel)
}

final class ReminderController: UIViewController {
    
	private var router: (ReminderRoutingLogic & ReminderDataPassing)?
	private let mainView = ReminderView.loadFromNib()
    private var interactor: ReminderBusinessLogic?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
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
		router.dataStore = interactor
        self.interactor = interactor
        self.router = router
		self.router?.dataStore = interactor
    }
	
	override func viewDidLoad() {
		self.view = self.mainView
		self.interactor?.makeState(requst: .start)
	}
}

extension ReminderController: ReminderDisplayLogic {
	func displayContent(show: Reminder.ViewModel) {
		switch show {
		case .display(let data):
			self.mainView.configure(with: data)
		case .present(let chapter):
			self.router?.presentController(chapter: chapter)
		}
	}
}
