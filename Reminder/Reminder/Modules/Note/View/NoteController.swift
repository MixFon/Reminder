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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
	
	func setPipe(pipe: NotePipe?) {
		self.router?.setPipe(pipe: pipe)
		self.router?.acceptData()
	}
    
    private func setup() {
		self.mainView.delegate = self
		
        let presenter = NotePresenter(controller: self)
        let interactor = NoteInteractor(presenter: presenter)
        let router = NoteRouter(controller: self)
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
			self.router?.presentAddNote()
		}
	}
}

extension NoteController: NoteViewAction {
	
	func addNote() {
		self.interactor?.makeState(requst: .addNote)
	}
	
	func closeView() {
		self.router?.returnChapter()
	}
}
