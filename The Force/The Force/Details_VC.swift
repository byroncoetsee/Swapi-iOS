//
//  Details_VC.swift
//  The Force
//
//  Created by Byron Coetsee on 2016/09/07.
//  Copyright © 2016 Byron Coetsee. All rights reserved.
//

import UIKit
import RealmSwift

class Details_VC: UIViewController {

	@IBOutlet weak var viewBlur: UIVisualEffectView!
	@IBOutlet weak var viewDetails: UIView!
	@IBOutlet weak var viewHeader: UIView!
	@IBOutlet weak var imgPic: UIImageView!
	@IBOutlet weak var lblHeading: Sub_UILabel!
	@IBOutlet weak var lblSubheading: Sub_UILabel!
	@IBOutlet weak var tblDetails: UITableView!
	
	var object: Object!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = UIColor.clearColor()
		
		viewDetails.backgroundColor = global.theme_mainColour
		viewDetails.layer.cornerRadius = 20
		viewDetails.clipsToBounds = true
		viewDetails.layer.shadowOffset = CGSizeZero
		viewDetails.layer.shadowRadius = 5
		viewDetails.layer.shadowOpacity = 0.5
		
		viewHeader.backgroundColor = global.theme_mainColour
		viewHeader.layer.shadowOffset = CGSizeZero
		viewHeader.layer.shadowRadius = 3
		viewHeader.layer.shadowOpacity = 0.5
		
		let tapClose = UITapGestureRecognizer(target: self, action: #selector(close))
		viewBlur.addGestureRecognizer(tapClose)
		
		setupHeader()
    }
	
	func setupHeader() {
		switch object {
		case is The_Force.Film:
			lblHeading.text = object.valueForKey("name") as! String
			lblSubheading.text = "Film"
			break
			
		case is The_Force.Character:
			lblHeading.text = object.valueForKey("name") as! String
			lblSubheading.text = "Character"
			break
			
		case is The_Force.Species:
			lblHeading.text = object.valueForKey("name") as! String
			lblSubheading.text = "Species"
			break
			
		case is The_Force.Vehicle:
			lblHeading.text = object.valueForKey("name") as! String
			lblSubheading.text = "Vehicle"
			break
			
		case is The_Force.Starship:
			lblHeading.text = object.valueForKey("name") as! String
			lblSubheading.text = "Starship"
			break
			
		case is The_Force.Planet:
			lblHeading.text = object.valueForKey("name") as! String
			lblSubheading.text = "Planet"
			break
			
		default:
			lblHeading.text = "Unknown"
			lblSubheading.text = "Unknown"
			break
		}
	}
	
	func close() {
		self.dismissViewControllerAnimated(true, completion: nil)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
