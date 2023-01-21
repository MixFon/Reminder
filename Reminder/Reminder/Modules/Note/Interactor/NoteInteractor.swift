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
	

	init(presenter: NotePresentationLogic? = nil) {
        self.presenter = presenter
    }
    
	func makeState(requst: NoteModel.Request) {
		switch requst {
		case .start:
			self.presenter?.buildState(response: .work(self.chapter))
		case .add:
			self.note = nil
			self.notion = NotionModel.Notion(
				text: nil,
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
		case .clean:
			self.chapter?.cleanAllNotes()
			makeState(requst: .start)
		}
	}
	
	private func deleteNote(note: _Note?) {
		self.chapter?.deleteNote(note: note)
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
		guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
		if self.note == nil {
			let dbNote = DBNote(context: context)
			dbNote.text = notion?.text
			dbNote.isSelect = false
			self.note = dbNote
		} else {
			self.note?.text = notion?.text
		}
		self.chapter?.addNote(note: self.note)
		makeState(requst: .start)
	}
}
