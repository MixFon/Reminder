//
//  NotionController.swift
//  Reminder
//
//  Created by Михаил Фокин on 21.12.2022.
//

import UIKit
import CoreExtensions

protocol NotionDisplayLogic: AnyObject {
	func displayContent(show: Notion.ViewModel)
}

final class NotionController: UIViewController {
	
	private var router: (NotionRoutingLogic & NotionDataPassing)?
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
        let presenter = NotionPresenter(controller: self)
        let interactor = NotionInteractor(presenter: presenter)
        let router = NotionRouter(controller: self)
        self.interactor = interactor
        self.router = router
		router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view = self.mainView
		self.interactor?.makeState(requst: .start)
    }
    
}

extension NotionController: NotionDisplayLogic {
    
	func displayContent(show: Notion.ViewModel) {
		switch show {
		case .display(let data):
			self.mainView.configure(with: data)
		case .present:
			self.router?.presentController()
		}
	}
	
}
