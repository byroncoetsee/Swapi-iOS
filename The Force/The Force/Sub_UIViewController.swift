//
//  Sub_UIViewController.swift
//  Heroku
//
//  Created by Byron Coetsee on 2016/05/16.
//  Copyright © 2016 Wixel (Pty) Ltd. All rights reserved.
//

import UIKit

class Sub_UIViewController: UIViewController {
	
	var loadingView: UIAlertController!
	var loadingVisible: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = global.theme_mainColour
		
		// Comment this line to unTransparentarize the Navi Controller
		if self.navigationController != nil {
			self.navigationController!.navigationBarHidden = true
			self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
			self.navigationController!.navigationBar.shadowImage = UIImage()
			self.navigationController!.navigationBar.translucent = true
//			self.navigationController!.navigationBar.tintColor = global.colour_opposing
		}
    }
	
	override func viewDidLayoutSubviews() {
		self.loadingView = getLoadingView()
	}
	
	func showLoading(completion: (() -> Void)? = nil) {
		if loadingVisible == false {
			loadingView.modalTransitionStyle = .CrossDissolve
			presentViewController(loadingView, animated: false, completion: {
				self.loadingVisible = true
				if completion != nil { completion!() }
			})
		}
	}
	
	func hideLoading(completion: (() -> Void)? = nil) {
		dispatch_async(dispatch_get_main_queue(), {
			if self.loadingVisible == true {
				self.dismissViewControllerAnimated(false, completion: {
					self.loadingVisible = false
					if completion != nil { completion!() }
				})
			}
		})
	}
	
	func getLoadingView() -> UIAlertController {
		let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .Alert)
		
		alert.view.tintColor = UIColor.blackColor()
		let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
		loadingIndicator.hidesWhenStopped = true
		loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
		loadingIndicator.startAnimating();
		
		alert.view.addSubview(loadingIndicator)
		return alert
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
