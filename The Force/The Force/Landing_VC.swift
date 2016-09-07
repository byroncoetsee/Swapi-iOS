//
//  Landing_VC.swift
//  The Force
//
//  Created by Byron Coetsee on 2016/09/07.
//  Copyright © 2016 Byron Coetsee. All rights reserved.
//

import UIKit

class Landing_VC: Sub_UIViewController {
	
	var monkeyCount : Int = 1
	
	@IBOutlet weak var lblMessage: Sub_UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		// Getting initial data
		addMonkey()
		api.getAll()
    }
	
	func addMonkey() {
		lblMessage.text! = "\(lblMessage.text!)\nMonkey \(monkeyCount)....................Loaded"
		monkeyCount += 1
		
		if api.gotFilms && api.gotCharacters && api.gotStarships && api.gotVehicles && api.gotPlanets && api.gotSpecies {
			NSNotificationCenter.defaultCenter().removeObserver(self)
			
			let vc = self.storyboard!.instantiateViewControllerWithIdentifier("main_vc") as! Main_VC
			vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
			self.presentViewController(vc, animated: true, completion: nil)
		} else {
			let randomInterval = Double(arc4random_uniform(6) + 1)/10
			NSTimer.scheduledTimerWithTimeInterval(randomInterval, target: self, selector: #selector(addMonkey), userInfo: nil, repeats: false)
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
