//
//  NoteController.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.12.2022.
//

import UIKit
import CoreExtensions

protocol NoteDisplayLogic: AnyObject {
	func displayContent(show: NoteModel.ViewModel)
}

final class NoteController: UIViewController {
    
	private let mainView = NoteView.loadFromNib()
	
	private var router: NoteRoutingLogic?
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
		router.dataStore = interactor
		self.router = router
        self.interactor = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view = self.mainView
		self.interactor?.makeState(requst: .start)
    }
}

extension NoteController: NoteDisplayLogic {
	
	func displayContent(show: NoteModel.ViewModel) {
		switch show {
		case .display(let data):
			self.mainView.configure(with: data)
		case .presentNotion:
			self.router?.presentNotion()
		case .delete(let note):
			self.interactor?.makeState(requst: .delete(note))
		case .changeIcon(let note):
			self.interactor?.makeState(requst: .changeIcon(note))
		case .edit(let note):
			self.interactor?.makeState(requst: .edit(note))
			self.router?.presentNotion()
		}
	}
}

extension NoteController: NoteViewAction {
	
	func addNote() {
		self.interactor?.makeState(requst: .add)
		self.router?.presentNotion()
	}
	
	func closeView() {
		self.router?.returnChapter()
	}
	
	func cleanAllNotes() {
		self.interactor?.makeState(requst: .clean)
	}
}
