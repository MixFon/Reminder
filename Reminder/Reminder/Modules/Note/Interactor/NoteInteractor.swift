//
//  NoteInteractor.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.12.2022.
//

import UIKit
import Foundation
import CoreData

protocol NoteBusinessLogic: AnyObject {
   func makeState(requst: NoteModel.Request)
}

protocol NoteDataStore {
	func getChapter() -> _Chapter?
	func setChapter(chapter: _Chapter?)
}

final class NoteInteractor: NoteBusinessLogic {
    
	private var note: _Note?
	private var notion: _Notion?
	private var chapter: _Chapter?
	private var presenter: NotePresentationLogic?
	
	private lazy var context: NSManagedObjectContext? = {
		return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
	}()

	init(presenter: NotePresentationLogic? = nil) {
        self.presenter = presenter
    }
    
	func makeState(requst: NoteModel.Request) {
		switch requst {
		case .start:
			self.presenter?.buildState(response: .work(self.chapter))
		case .add:
			self.note = NoteModel.Note()
			self.notion = NotionModel.Notion(
				text: self.note?.text,
				title: self.chapter?.text,
				buttonTitle: "Добавить"
			)
		case .edit(let note):
			self.note = note
			self.notion = NotionModel.Notion(
				text: self.note?.text,
				title: self.chapter?.text,
				buttonTitle: "Изменить"
			)
		case .delete(let note):
			deleteNote(note: note)
		case .changeIcon(let note):
			self.note = note
			self.note?.changeIcon()
			makeState(requst: .start)
			//changeIconNote(note: note)
		}
	}
	
	private func deleteNote(note: _Note?) {
		self.chapter?.deleteNote(note: note)
		makeState(requst: .start)
	}
	
	private func changeIconNote(note: _Note?) {
		self.chapter?.changeNoteIcon(note: note)
		makeState(requst: .start)
	}
}

extension NoteInteractor: NoteDataStore {

	func setChapter(chapter: _Chapter?) {
		self.chapter = chapter
	}
	
	func getChapter() -> _Chapter? {
		return self.chapter
	}
}

extension NoteInteractor: NotionPipe {
	
	func acceptData() -> _Notion? {
		return self.notion
	}
	
	func returnNotion(notion: _Notion?) {
		let dbNote = DBNote(context: self.context!)
		dbNote.text = notion?.text
		dbNote.isSelect = false
		self.chapter?.addNote(note: dbNote)
		makeState(requst: .start)
	}
}
