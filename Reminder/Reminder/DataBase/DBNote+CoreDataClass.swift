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
	
	var hachValue: Int?
	
	func changeIcon() {
		//debugPrint(self.image?.getBool())
		//self.image?.opositeImage()
		//debugPrint(self.image?.getBool())
		self.isSelect = !(self.image?.getBool() ?? true)
		(UIApplication.shared.delegate as? AppDelegate)?.saveContext()
	}
	
}
