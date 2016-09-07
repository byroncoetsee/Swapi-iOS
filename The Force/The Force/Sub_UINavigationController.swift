//
//  Sub_UINavigationController.swift
//  Heroku
//
//  Created by Byron Coetsee on 2016/05/19.
//  Copyright © 2016 Wixel (Pty) Ltd. All rights reserved.
//

import UIKit

class Sub_UINavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func pushViewController(viewController: UIViewController, animated: Bool) {
		addTransitionLayer()
		super.pushViewController(viewController, animated: animated)
	}
	
	override func popViewControllerAnimated(animated: Bool) -> UIViewController? {
		addTransitionLayer()
		super.popViewControllerAnimated(false)
		return nil
	}
	
	func addTransitionLayer () {
		let transition = CATransition()
		transition.duration = 0.5
		transition.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
		transition.type = kCATransitionFade
		view.layer.addAnimation(transition, forKey: nil)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
