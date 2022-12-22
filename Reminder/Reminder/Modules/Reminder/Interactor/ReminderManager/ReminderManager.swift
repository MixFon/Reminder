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
			MockChapter.init(notes: ["Плавки", "Шапочка", "Носки", "Очки"] , chapter: "Бассейн"),
			MockChapter.init(notes: ["Ботинки", "Шорты", "Носки", "Ботинки"] , chapter: "Фитнес")
		]
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
