//
//  DBNote+CoreDataClass.swift
//  Reminder
//
//  Created by Михаил Фокин on 10.01.2023.
//
//

import UIKit
import CoreData
import Foundation

@objc(DBNote)
public class DBNote: NSManagedObject, _Note {
	var image: IconNote? {
		get {
			return IconNote(isSelect: self.isSelect)
		}
	}
	
	func changeIcon() {
		self.isSelect = !self.isSelect
		(UIApplication.shared.delegate as? AppDelegate)?.saveContext()
	}
	
	func cleanIcon() {
		self.isSelect = false
	}
	
}
