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
	
	private lazy var context: NSManagedObjectContext? = {
		return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
	}()
	
	private func saveContext() {
		(UIApplication.shared.delegate as? AppDelegate)?.saveContext()
	}
	
	func getChapters() -> [_Chapter]? {
		let noteFetch: NSFetchRequest<DBChapter> = DBChapter.fetchRequest()
		do {
			let result = try self.context?.fetch(noteFetch)
			return result
		} catch let error as NSError {
			print("Fetch error: \(error) description: \(error.userInfo)")
		}
		return nil
	}
	
	private func isExist(chapter: _Chapter?) -> Bool {
		do {
			let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Chapter")
			fetchRequest.fetchLimit =  1
			fetchRequest.predicate = NSPredicate(format: "text == %@" , chapter?.text ?? "")
			if let count = try self.context?.count(for: fetchRequest) {
				return count > 0
			} else {
				return false
			}
		} catch let error as NSError {
			print("Fetch error: \(error) description: \(error.userInfo)")
		}
		return false
		
	}
	
	func updateOrSaveChapter(chapter: _Chapter?) {
		if !isExist(chapter: chapter) {
			let dbChapter = DBChapter(context: self.context!)
			dbChapter.text = chapter?.text
		}
		saveContext()
	}
	
	func deleteChapter(chapter: _Chapter?) {
		guard let dbCapter = chapter as? DBChapter else { return }
		self.context?.delete(dbCapter)
		saveContext()
	}
	
	func getNewChapter() -> _Chapter? {
		guard let context else { return nil }
		let chapter = DBChapter(context: context)
		return chapter
	}
}
