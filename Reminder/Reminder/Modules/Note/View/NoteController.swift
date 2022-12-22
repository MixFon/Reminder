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
	
	private var router: (NoteRoutingLogic & NoteDataPassing)?
	private var interactor: NoteBusinessLogic?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
	
	init(chapter: _Chapter? = nil, dataReturn: ReminderDataReturn? = nil) {
		super.init(nibName: nil, bundle: nil)
		setup(chapter: chapter, dataReturn: dataReturn)
	}
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
	
	func setDataAccept(dataAccept: NoteDataAccept?) {
		self.router?.setDataAccept(dataAccept: dataAccept)
	}
    
    private func setup(chapter: _Chapter? = nil, dataReturn: ReminderDataReturn? = nil) {
		self.mainView.delegate = self
		
        let presenter = NotePresenter(controller: self)
        let interactor = NoteInteractor(presenter: presenter, chapter: chapter)
        let router = NoteRouter(controller: self, dataReturn: dataReturn)
        self.interactor = interactor
        self.router = router
		self.router?.dataStore = interactor
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
		case .present:
			return
		}
	}
}

extension NoteController: NoteViewAction {
	func closeView() {
		self.router?.returnChapter()
	}
}
