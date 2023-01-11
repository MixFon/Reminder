//
//  ReminderManager.swift
//  Reminder
//
//  Created by Михаил Фокин on 11.12.2022.
//

import Foundation
import CoreData
import UIKit

final class ReminderManager {
	
	private var chapters: [_Chapter]?
	
	var context: NSManagedObjectContext? = {
		return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
	}()
	
	
	
	init() {
		self.chapters = [
			ReminderModel.Chapter.init(
				text: "Бассейн",
				notes: [
					NoteModel.Note(text: "Плавки", image: .off),
					NoteModel.Note(text: "Шапочка", image: .off),
					NoteModel.Note(text: "Носки", image: .off),
					NoteModel.Note(text: "Очки", image: .off)
				]
			),
			ReminderModel.Chapter.init(
				text: "Фитнес",
				notes: [
					NoteModel.Note(text: "Ботинки", image: .off),
					NoteModel.Note(text: "Шорты", image: .off),
					NoteModel.Note(text: "Носки", image: .off),
					NoteModel.Note(text: "Ботинки", image: .off)
				]
			)
		]
	}
	
	func saveChapter(chapter: _Chapter?) {
		guard let context else { return }
		let dbChapter = DBChapter(context: context)
		dbChapter.text = chapter?.text
		(UIApplication.shared.delegate as? AppDelegate)?.saveContext()
	}
	
	func getChapters() -> [_Chapter]? {
		let noteFetch: NSFetchRequest<DBChapter> = DBChapter.fetchRequest()
		do {
			//let managedContext = AppDelegate.coreDataSatack
			let results = try self.context?.fetch(noteFetch)
			for res in results ?? [] {
				debugPrint(res.text)
				debugPrint(res.note)
			}
		} catch let error as NSError {
			print("Fetch error: \(error) description: \(error.userInfo)")
		}
		return self.chapters
	}
}
