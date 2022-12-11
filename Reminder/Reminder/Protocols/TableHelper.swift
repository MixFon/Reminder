//
//  TableHelper.swift
//  Reminder
//
//  Created by Михаил Фокин on 04.12.2022.
//

import Foundation
import CoreTableView

protocol _TableHelper {
	func makeState() -> State
	func makeHeader() -> HeaderData?
	func makeFooter() -> FooterData?
	func makeElements() -> [Element]
	func makeSection() -> SectionState
}
