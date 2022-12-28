//
//  NotionController.swift
//  Reminder
//
//  Created by Михаил Фокин on 21.12.2022.
//

import UIKit
import CoreExtensions

protocol NotionDisplayLogic: AnyObject {
	func displayContent(show: NotionModel.ViewModel)
}

final class NotionController: UIViewController {
	
	private var router: NotionRoutingLogic?
	private let mainView = NotionView.loadFromNib()
	private var interactor: NotionBusinessLogic?
    
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
		self.mainView.setNotification()
		
        let presenter = NotionPresenter(controller: self)
        let interactor = NotionInteractor(presenter: presenter)
        let router = NotionRouter(controller: self)
		router.dataStore = interactor
        self.interactor = interactor
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view = self.mainView
		self.interactor?.makeState(requst: .work)
    }
	
	func setPipe(pipe: NotionPipe?) {
		self.router?.setPipe(pipe: pipe)
		self.router?.acceptData()
	}
}

extension NotionController: NotionDisplayLogic {
    
	func displayContent(show: NotionModel.ViewModel) {
		switch show {
		case .display(let data):
			self.mainView.configure(with: data)
		case .present:
			self.router?.presentController()
		}
	}
	
}

extension NotionController: NotionViewAction {
	
	func pressChenge() {
		self.router?.pressChenge()
	}
	
	func textChenge(text: String?) {
		self.interactor?.makeState(requst: .changeText(text))
	}
}
