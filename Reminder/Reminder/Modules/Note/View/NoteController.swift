//
//  NoteController.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.12.2022.
//

import UIKit
import CoreExtensions

protocol NoteDisplayLogic: AnyObject {
	func displayContent(show: Note.ViewModel)
}

final class NoteController: UIViewController {
    
	private let mainView = NoteView.loadFromNib()
	
	private var interactor: NoteBusinessLogic?
	private var router: NoteRoutingLogic?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "NoteController", bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        let presenter = NotePresenter(controller: self)
        let interactor = NoteInteractor(presenter: presenter)
        let router = NoteRouter(controller: self)
        self.interactor = interactor
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view = self.mainView
		self.interactor?.makeState(requst: .start)
    }
    
}

extension NoteController: NoteDisplayLogic {
	
	func displayContent(show: Note.ViewModel) {
		switch show {
		case .display(let data):
			self.mainView.configure(with: data)
		}
	}
	
    
}
