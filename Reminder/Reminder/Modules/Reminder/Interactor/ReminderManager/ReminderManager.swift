//
//  ReminderManager.swift
//  Reminder
//
//  Created by Михаил Фокин on 11.12.2022.
//

import Foundation

final class ReminderManager {
	
	func getChapters() -> [_Chapter] {
		let mock: [MockChapter] = [
			.init(notes: ["Плавки", "Шапочка", "Носки", "Очки"] , chapter: "Бассейн"),
			.init(notes: ["Ботинки", "Шорты", "Носки", "Ботинки"] , chapter: "Фитнес")
		]
		return mock
	}
}
