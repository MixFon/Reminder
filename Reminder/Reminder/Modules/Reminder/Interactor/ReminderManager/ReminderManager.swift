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
			MockChapter.init(
				notes: [
					MockNote(title: "Плавки", image: nil),
					MockNote(title: "Шапочка", image: nil),
					MockNote(title: "Носки", image: nil),
					MockNote(title: "Очки", image: nil)
				],
				chapter: "Бассейн"
			),
			MockChapter.init(
				notes: [
					MockNote(title: "Ботинки", image: nil),
					MockNote(title: "Шорты", image: nil),
					MockNote(title: "Носки", image: nil),
					MockNote(title: "Ботинки", image: nil)
				],
				chapter: "Фитнес"
			)
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
