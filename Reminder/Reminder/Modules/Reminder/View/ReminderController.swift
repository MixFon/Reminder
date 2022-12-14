//
//  ReminderController.swift
//  Reminder
//
//  Created by Михаил Фокин on 04.12.2022.
//

import UIKit
import CoreExtensions

protocol ReminderDisplayLogic: AnyObject {
	func displayContent(show: ReminderModel.ViewModel)
}

final class ReminderController: UIViewController {
    
	private var router: ReminderRoutingLogic?
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
		self.mainView.delegate = self
		
        let presenter = ReminderPresenter(controller: self)
        let interactor = ReminderInteractor(presenter: presenter)
        let router = ReminderRouter(controller: self)
		router.dataStore = interactor
        self.interactor = interactor
        self.router = router
    }
	
	override func viewDidLoad() {
		self.view = self.mainView
		self.interactor?.makeState(requst: .start)
	}
}

extension ReminderController: ReminderDisplayLogic {
	
	func displayContent(show: ReminderModel.ViewModel) {
		switch show {
		case .display(let data):
			self.mainView.configure(with: data)
		case .edit(let chapter):
			self.interactor?.makeState(requst: .edit(chapter))
			self.router?.presentNotionController()
		case .delete(let chapter):
			self.interactor?.makeState(requst: .delete(chapter))
		case .present(let chapter):
			self.interactor?.makeState(requst: .selectChapter(chapter))
			self.router?.presentController()
		}
	}
}

extension ReminderController: ReminderViewAction {
	
	func addNewChapter() {
		self.interactor?.makeState(requst: .add)
		self.router?.presentNotionController()
	}
}
