//
//  ViewController.swift
//  The Force
//
//  Created by Byron Coetsee on 2016/09/01.
//  Copyright © 2016 Byron Coetsee. All rights reserved.
//

import UIKit
import RealmSwift

class Main_VC: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var txtSearch: UITextField!
	@IBOutlet weak var tblResults: UITableView!
	@IBOutlet weak var viewTotals: UIView!
	@IBOutlet weak var lblFilms: Sub_UILabel!
	@IBOutlet weak var lblChars: Sub_UILabel!
	@IBOutlet weak var lblPlanets: Sub_UILabel!
	@IBOutlet weak var lblSpecies: Sub_UILabel!
	@IBOutlet weak var lblStarships: Sub_UILabel!
	@IBOutlet weak var lblVehicles: Sub_UILabel!
	
	var sectionHeadings: [String] = []
	var filteredResults: [String : [Object]] = [:]
	
	var filteredResults_Films: Results<Film>?
	var filteredResults_Characters: Results<Character>?
	var filteredResults_Species: Results<Species>?
	var filteredResults_Vehicles: Results<Vehicle>?
	var filteredResults_Starships: Results<Starship>?
	var filteredResults_Planets: Results<Planet>?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = global.theme_mainColour
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		tap.cancelsTouchesInView = false
		self.view.addGestureRecognizer(tap)
		
		tblResults.hidden = true
		setTotals()
	}
	
	func setTotals() {
		let realm = try! Realm()
		try! realm.write({
			lblFilms.text = "\(realm.objects(Film).count)"
			lblChars.text = "\(realm.objects(Character).count)"
			lblSpecies.text = "\(realm.objects(Species).count)"
			lblStarships.text = "\(realm.objects(Starship).count)"
			lblVehicles.text = "\(realm.objects(Vehicle).count)"
			lblPlanets.text = "\(realm.objects(Planet).count)"
		})
	}
	
	func dismissKeyboard() {
		self.view.endEditing(true)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
}

// =======================
// TableView functions
// =======================

extension Main_VC: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return sectionHeadings.count
	}
	
	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
		let gradient:CAGradientLayer = CAGradientLayer()
		gradient.frame.size = view.frame.size
		gradient.colors = [global.theme_mainColour.CGColor, global.theme_mainColour.colorWithAlphaComponent(0).CGColor]
		view.layer.addSublayer(gradient)
		return view
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch sectionHeadings[section] {
		case "Films":
			return filteredResults_Films!.count
		case "Characters":
			return filteredResults_Characters!.count
		case "Species":
			return filteredResults_Species!.count
		case "Vehicles":
			return filteredResults_Vehicles!.count
		case "Starships":
			return filteredResults_Starships!.count
		case "Planets":
			return filteredResults_Planets!.count
		default:
			return 0
		}
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tblResults.dequeueReusableCellWithIdentifier("result_cell") as! Result_Cell
		return cell
	}
	
	func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
		let _cell = cell as! Result_Cell
		
		switch sectionHeadings[indexPath.section] {
		case "Films":
			_cell.setup(filteredResults_Films![indexPath.row])
		case "Characters":
			_cell.setup(filteredResults_Characters![indexPath.row])
		case "Species":
			_cell.setup(filteredResults_Species![indexPath.row])
		case "Vehicles":
			_cell.setup(filteredResults_Vehicles![indexPath.row])
		case "Starships":
			_cell.setup(filteredResults_Starships![indexPath.row])
		case "Planets":
			_cell.setup(filteredResults_Planets![indexPath.row])
		default:
			break
		}
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let vc = storyboard!.instantiateViewControllerWithIdentifier("details_vc") as! Details_VC
		switch sectionHeadings[indexPath.section] {
		case "Films":
			vc.object = filteredResults_Films![indexPath.row]
		case "Characters":
			vc.object = filteredResults_Characters![indexPath.row]
		case "Species":
			vc.object = filteredResults_Species![indexPath.row]
		case "Vehicles":
			vc.object = filteredResults_Vehicles![indexPath.row]
		case "Starships":
			vc.object = filteredResults_Starships![indexPath.row]
		case "Planets":
			vc.object = filteredResults_Planets![indexPath.row]
		default:
			break
		}
		tblResults.deselectRowAtIndexPath(indexPath, animated: true)
		vc.modalPresentationStyle = .OverCurrentContext
		vc.modalTransitionStyle = .CrossDissolve
		self.presentViewController(vc, animated: true, completion: nil)
	}
}

// =======================
// TextField functions
// =======================

extension Main_VC {
	
	@IBAction func searchEditingBegan(sender: AnyObject) {
		viewTotals.hidden = true
	}
	
	@IBAction func search(sender: AnyObject) {
		let realm = try! Realm()
		try! realm.write({
			let films = realm.objects(Film).filter("name CONTAINS[c] '\(txtSearch.text!)'")
			let characters = realm.objects(Character).filter("name CONTAINS[c] '\(txtSearch.text!)'")
			let species = realm.objects(Species).filter("name CONTAINS[c] '\(txtSearch.text!)'")
			let vehicles = realm.objects(Vehicle).filter("name CONTAINS[c] '\(txtSearch.text!)'")
			let starships = realm.objects(Starship).filter("name CONTAINS[c] '\(txtSearch.text!)'")
			let planets = realm.objects(Planet).filter("name CONTAINS[c] '\(txtSearch.text!)'")
			
			sectionHeadings = []
			if films.count > 0 { sectionHeadings.append("Films") }
			if characters.count > 0 { sectionHeadings.append("Characters") }
			if species.count > 0 { sectionHeadings.append("Species") }
			if vehicles.count > 0 { sectionHeadings.append("Vehicles") }
			if starships.count > 0 { sectionHeadings.append("Starships") }
			if planets.count > 0 { sectionHeadings.append("Planets") }
			
			filteredResults_Films = films
			filteredResults_Characters = characters
			filteredResults_Species = species
			filteredResults_Vehicles = vehicles
			filteredResults_Starships = starships
			filteredResults_Planets = planets
			
			tblResults.reloadData()
			print(characters.count)
		})
		
		if txtSearch.text?.characters.count > 0 {
			tblResults.hidden = false
			viewTotals.hidden = true
		} else {
			tblResults.hidden = true
		}
	}
	
	@IBAction func searchEditingEnded(sender: AnyObject) {
		if txtSearch.text!.characters.count == 0 {
			viewTotals.hidden = false
		} else {
			viewTotals.hidden = true
		}
	}
}






