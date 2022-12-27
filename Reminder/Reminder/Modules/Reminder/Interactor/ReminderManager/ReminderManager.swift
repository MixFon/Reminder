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
				notes: [
					NoteModel.Note(text: "Плавки", image: .off),
					NoteModel.Note(text: "Шапочка", image: .off),
					NoteModel.Note(text: "Носки", image: .off),
					NoteModel.Note(text: "Очки", image: .off)
				],
				chapter: "Бассейн"
			),
			ReminderModel.Chapter.init(
				notes: [
					NoteModel.Note(text: "Ботинки", image: .off),
					NoteModel.Note(text: "Шорты", image: .off),
					NoteModel.Note(text: "Носки", image: .off),
					NoteModel.Note(text: "Ботинки", image: .off)
				],
				chapter: "Фитнес"
			)
		]
		updateChapters()
	}
	
	private func updateChapters() {
		for index in (self.chapters ?? []).indices {
			self.chapters?[index].updateIndexes()
			debugPrint(self.chapters?[index])
		}
	}
	
	
	func getChapters() -> [_Chapter]? {
		return self.chapters
	}
	
	func setChapter(chapter: _Chapter?) {
		guard let chapter else { return }
		for (i, element) in (self.chapters ?? []).enumerated() {
			if element.chapter == chapter.chapter {
				self.chapters?[i].notes = chapter.notes
				return
			}
		}
		self.chapters?.append(chapter)
	}
}
