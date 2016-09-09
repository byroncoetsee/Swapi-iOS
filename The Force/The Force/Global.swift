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

extension Object {
	func toDictionary() -> NSDictionary {
		let properties = self.objectSchema.properties.map { $0.name }
		let dictionary = self.dictionaryWithValuesForKeys(properties)
		
		let mutabledic = NSMutableDictionary()
		mutabledic.setValuesForKeysWithDictionary(dictionary)
		
		for prop in self.objectSchema.properties as [Property]! {
			// find lists
			if let nestedObject = self[prop.name] as? Object {
				mutabledic.setValue(nestedObject.toDictionary(), forKey: prop.name)
			} else if let nestedListObject = self[prop.name] as? ListBase {
				var objects = [AnyObject]()
				for index in 0..<nestedListObject._rlmArray.count  {
					let object = nestedListObject._rlmArray[index] as AnyObject
					objects.append(object.toDictionary())
				}
				mutabledic.setObject(objects, forKey: prop.name)
			}
			
		}
		return mutabledic
	}
}