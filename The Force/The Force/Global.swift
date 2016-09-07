//
//  Global.swift
//  The Force
//
//  Created by Byron Coetsee on 2016/09/01.
//  Copyright © 2016 Byron Coetsee. All rights reserved.
//

import UIKit
import ChameleonFramework
import RealmSwift

let global = Global()

class Global: NSObject {
	
	let theme_mainColour = UIColor(hexString: "B1E67B") //UIColor.randomFlatColor()
	let theme_textColour: UIColor!
	
	override init() {
		theme_textColour = theme_mainColour.darkenByPercentage(0.3)
	}
	
	func getIdFromURL(url: String) -> Int {
		if let url = NSURL(string: url) {
			return Int(url.lastPathComponent!)!
		}
		return random()
	}

}