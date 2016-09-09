//
//  Result_Cell.swift
//  The Force
//
//  Created by Byron Coetsee on 2016/09/07.
//  Copyright © 2016 Byron Coetsee. All rights reserved.
//

import UIKit
import RealmSwift

class Result_Cell: UITableViewCell {
	
	var object: Object!

	@IBOutlet weak var imgPic: Sub_UIImageView!
	@IBOutlet weak var lblMainText: Sub_UILabel!
	@IBOutlet weak var lblType: Sub_UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
		imgPic.layer.cornerRadius = imgPic.frame.height/2
		imgPic.layer.borderColor = global.theme_textColour.CGColor
		imgPic.layer.borderWidth = 1
    }
	
	func setup(object: Object) {
		switch object {
		case is The_Force.Film:
			lblMainText.text! = object.valueForKey("name") as! String
			lblType.text = "Film"
			break
			
		case is The_Force.Character:
			lblMainText.text! = object.valueForKey("name") as! String
			lblType.text = "Character"
			break
			
		case is The_Force.Species:
			lblMainText.text! = object.valueForKey("name") as! String
			lblType.text = "Species"
			break
			
		case is The_Force.Vehicle:
			lblMainText.text! = object.valueForKey("name") as! String
			lblType.text = "Vehicle"
			break
			
		case is The_Force.Starship:
			lblMainText.text! = object.valueForKey("name") as! String
			lblType.text = "Starship"
			break
			
		case is The_Force.Planet:
			lblMainText.text! = object.valueForKey("name") as! String
			lblType.text = "Planet"
			break
			
		default:
			lblMainText.text = "Unknown"
			lblType.text = "Unknown"
			break
		}
		
		self.object = object
	}

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
