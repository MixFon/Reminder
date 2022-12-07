//
//  Colors.swift
//  Reminder
//
//  Created by Михаил Фокин on 07.12.2022.
//

import UIKit

public extension UIColor {
	
	static func getAssetColor(name: String) -> UIColor {
		return UIColor(named: name, in: nil, compatibleWith: nil) ?? UIColor.red
	}
	
	static var BackgroundPrimary : UIColor {
		return UIColor.getAssetColor(name: #function)
	}
	
	static var BackgroundSecondary : UIColor {
		return UIColor.getAssetColor(name: #function)
	}
	
	static var Danger: UIColor {
		return UIColor.getAssetColor(name: #function)
	}
	
	static var Warning: UIColor {
		return UIColor.getAssetColor(name: #function)
	}
	
	static var Green: UIColor {
		return UIColor.getAssetColor(name: #function)
	}
	
	static var TextPrimary : UIColor {
		return UIColor.getAssetColor(name: #function)
	}
	
	static var TextSecondary : UIColor {
		return UIColor.getAssetColor(name: #function)
	}
	
	static var TintPrimary : UIColor {
		return UIColor.getAssetColor(name: #function)
	}
	
	static var Icons : UIColor {
		return UIColor.getAssetColor(name: #function)
	}
}
