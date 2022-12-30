//
//  ReminderManager.swift
//  Reminder
//
//  Created by Михаил Фокин on 11.12.2022.
//

import Foundation

final class ReminderManager {
	
	private var chapters: [_Chapter]?
	
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
	
	func getChapters() -> [_Chapter]? {
		return self.chapters
	}
}
