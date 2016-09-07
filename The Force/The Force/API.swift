//
//  API.swift
//  The Force
//
//  Created by Byron Coetsee on 2016/09/01.
//  Copyright © 2016 Byron Coetsee. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireSwiftyJSON //now response.result.value is SwiftyJSON.JSON type
import SwiftyJSON
import RealmSwift

let api = API()

class API: NSObject {
	
	var gotFilms = false
	var gotCharacters = false
	var gotSpecies = false
	var gotPlanets = false
	var gotVehicles = false
	var gotStarships = false
	
	func getAll() {
		print(Realm.Configuration.defaultConfiguration.fileURL)
		getFilms()
		getCharacters()
		getPlanets()
		getSpecies()
		getStarships()
		getVehicles()
	}
	
	func getFilms(page: String? = nil) {
		
		var URL = "http://swapi.co/api/films/"
		if page != nil { URL = page! }
		
		Alamofire.request(.GET, URL, parameters: nil).responseSwiftyJSON { response in
			
			if response.result.value != nil {
				let json = response.result.value!
				if json["next"] != nil { self.getCharacters(json["next"].stringValue) }
				
				for film in json["results"] {
					let realm = try! Realm()
					try! realm.write({
						
						let record = Film()
						record.id = film.1["url"].stringValue
						record.name = film.1["title"].stringValue
						record.episodeId = film.1["episode_id"].intValue
						record.openingCrawl = film.1["opening_crawl"].stringValue
						record.director = film.1["director"].stringValue
						record.producer = film.1["producer"].stringValue
						record.characters = self.createCharacterList(film.1["characters"], realm: realm)
						record.starships = self.createStarshipList(film.1["starships"], realm: realm)
						record.planets = self.createPlanetList(film.1["planets"], realm: realm)
						record.speciess = self.createSpeciesList(film.1["species"], realm: realm)
						record.vehicles = self.createVehicleList(film.1["vehicles"], realm: realm)
						realm.add(record, update: true)
					})
				}
			}
			self.gotFilms = true
			NSNotificationCenter.defaultCenter().postNotificationName("gotFilms", object: nil)
		}
	}
	
	func getCharacters(page: String? = nil) {
		
		var URL = "http://swapi.co/api/people/"
		if page != nil { URL = page! }
		
		Alamofire.request(.GET, URL, parameters: nil).responseSwiftyJSON { response in
			
			if response.result.value != nil {
				let json = response.result.value!
				if json["next"] != nil { self.getCharacters(json["next"].stringValue) }
				
				for char in json["results"] {
					let realm = try! Realm()
					try! realm.write({
						
						let record = Character()
						record.id = char.1["url"].stringValue
						record.name = char.1["name"].stringValue
						record.birthdate = char.1["birth_year"].intValue
						record.eyeColour = char.1["eye_color"].stringValue
						record.hairColour = char.1["hair_color"].stringValue
						record.skinColour = char.1["skin_color"].stringValue
						record.height = char.1["height"].intValue
						record.mass = char.1["mass"].doubleValue
						record.gender = char.1["gender"].bool
						record.films = self.createFilmList(char.1["films"], realm: realm)
						record.speciess = self.createSpeciesList(char.1["species"], realm: realm)
						record.starships = self.createStarshipList(char.1["starships"], realm: realm)
						record.vehicles = self.createVehicleList(char.1["vehicles"], realm: realm)
						
//						if realm.objectForPrimaryKey(Planet.self, key: char.1["homeworld"].stringValue) == nil {
//							let object = Planet(value: ["id" : char.1["homeworld"].stringValue])
//							realm.add(object, update: true)
//						}
//						record.homeWorld = realm.objectForPrimaryKey(Planet.self, key: char.1["homeworld"].stringValue)
					
						realm.add(record, update: true)
					})
				}
			}
			
			self.gotCharacters = true
			NSNotificationCenter.defaultCenter().postNotificationName("gotCharacters", object: nil)
		}
	}
	
	func getPlanets(page: String? = nil) {
		
		var URL = "http://swapi.co/api/planets/"
		if page != nil { URL = page! }
		
		Alamofire.request(.GET, URL, parameters: nil).responseSwiftyJSON { response in
			
			if response.result.value != nil {
				let json = response.result.value!
				if json["next"] != nil { self.getPlanets(json["next"].stringValue) }
				
				for char in json["results"] {
					let realm = try! Realm()
					try! realm.write({
						
						let record = Planet()
						record.id = char.1["url"].stringValue
						record.name = char.1["name"].stringValue
						record.diameter = char.1["diameter"].intValue
						record.rotationPeriod = char.1["rotation_period"].intValue
						record.orbitalPeriod = char.1["orbital_period"].stringValue
						record.gravity = char.1["gravity"].doubleValue
						record.population = char.1["population"].intValue
						record.climate = char.1["climate"].stringValue
						record.terrain = char.1["terrain"].stringValue
						record.water = char.1["surface_water"].doubleValue
						record.residents = self.createCharacterList(char.1["residents"], realm: realm)
						record.films = self.createFilmList(char.1["films"], realm: realm)
						realm.add(record, update: true)
					})
				}
			}
			self.gotPlanets = true
			NSNotificationCenter.defaultCenter().postNotificationName("gotPlanets", object: nil)
		}
	}
	
	func getSpecies(page: String? = nil) {
		var URL = "http://swapi.co/api/species/"
		if page != nil { URL = page! }
		
		Alamofire.request(.GET, URL, parameters: nil).responseSwiftyJSON { response in
			
			if response.result.value != nil {
				let json = response.result.value!
				if json["next"] != nil { self.getSpecies(json["next"].stringValue) }
				
				for char in json["results"] {
					let realm = try! Realm()
					try! realm.write({
						
						let record = Species()
						record.id = char.1["url"].stringValue
						record.name = char.1["name"].stringValue
						record.classification = char.1["classification"].stringValue
						record.designation = char.1["designation"].stringValue
						record.height = char.1["average_height"].intValue
						record.lifespan = char.1["average_lifespan"].intValue
						record.eyeColoure = char.1["eye_colors"].stringValue
						record.skinColours = char.1["skin_colors"].stringValue
						record.language = char.1["language"].stringValue
						record.characters = self.createCharacterList(char.1["people"], realm: realm)
						record.films = self.createFilmList(char.1["films"], realm: realm)
						
						if realm.objectForPrimaryKey(Planet.self, key: char.1["homeworld"].stringValue) == nil {
							let object = Planet(value: ["id" : char.1["homeworld"].stringValue])
							realm.add(object, update: true)
						}
						record.homeWorld = realm.objectForPrimaryKey(Planet.self, key: char.1["homeworld"].stringValue)
						
						realm.add(record, update: true)
					})
				}
			}
			self.gotSpecies = true
			NSNotificationCenter.defaultCenter().postNotificationName("gotSpecies", object: nil)
		}
	}
	
	func getStarships(page: String? = nil) {
		var URL = "http://swapi.co/api/starships/"
		if page != nil { URL = page! }
		
		Alamofire.request(.GET, URL, parameters: nil).responseSwiftyJSON { response in
			
			if response.result.value != nil {
				let json = response.result.value!
				if json["next"] != nil { self.getStarships(json["next"].stringValue) }
				
				for char in json["results"] {
					let realm = try! Realm()
					try! realm.write({
						
						let record = Starship()
						record.id = char.1["url"].stringValue
						record.name = char.1["name"].stringValue
						record.model = char.1["model"].stringValue
						record.manufacturer = char.1["manufacturer"].stringValue
						record.cost = char.1["cost_in_credits"].doubleValue
						record.length = char.1["length"].intValue
						record.crew = char.1["crew"].intValue
						record.passengers = char.1["passengers"].intValue
						record.speed_atmosphere = char.1["max_atmosphering_speed"].intValue
						record.hyperdriveRating = char.1["hyperdrive_rating"].doubleValue
						record.MGLT = char.1["MGLT"].doubleValue
						record.cargoCapacity = char.1["cargo_capacity"].doubleValue
						record.consumables = char.1["consumables"].stringValue
						
						record.pilots = self.createCharacterList(char.1["pilots"], realm: realm)
						record.films = self.createFilmList(char.1["films"], realm: realm)
						
						realm.add(record, update: true)
					})
				}
			}
			self.gotStarships = true
			NSNotificationCenter.defaultCenter().postNotificationName("gotStarships", object: nil)
		}
	}
	
	func getVehicles(page: String? = nil) {
		var URL = "http://swapi.co/api/vehicles/"
		if page != nil { URL = page! }
		
		Alamofire.request(.GET, URL, parameters: nil).responseSwiftyJSON { response in
			
			if response.result.value != nil {
				let json = response.result.value!
				if json["next"] != nil { self.getVehicles(json["next"].stringValue) }
				
				for char in json["results"] {
					let realm = try! Realm()
					try! realm.write({
						
						let record = Vehicle()
						record.id = char.1["url"].stringValue
						record.name = char.1["name"].stringValue
						record.model = char.1["model"].stringValue
						record.vehicleClass = char.1["vehicle_class"].stringValue
						record.manufacturer = char.1["manufacturer"].stringValue
						record.cost = char.1["cost_in_credits"].doubleValue
						record.length = char.1["length"].intValue
						record.crew = char.1["crew"].intValue
						record.passengers = char.1["passengers"].intValue
						record.speed_atmosphere = char.1["max_atmosphering_speed"].intValue
						record.cargoCapacity = char.1["cargo_capacity"].doubleValue
						record.consumables = char.1["consumables"].stringValue
						
						record.pilots = self.createCharacterList(char.1["pilots"], realm: realm)
						record.films = self.createFilmList(char.1["films"], realm: realm)
						
						realm.add(record, update: true)
					})
				}
			}
			self.gotVehicles = true
			NSNotificationCenter.defaultCenter().postNotificationName("gotVehicles", object: nil)
		}
	}
	
	
	// =========
	// Adding lists
	// =========
	
	func createCharacterList(json: JSON, realm: Realm) -> List<Character> {
		var array: [Character] = []
		for id in json {
			if realm.objectForPrimaryKey(Character.self, key: id.1.stringValue) == nil {
				let object = Character(value: ["id" : id.1.stringValue])
				realm.add(object, update: true)
			}
			array.append(realm.objectForPrimaryKey(Character.self, key: id.1.stringValue)!)
		}
		return List(array)
	}
	func createFilmList(json: JSON, realm: Realm) -> List<Film> {
		var array: [Film] = []
		for id in json {
			if realm.objectForPrimaryKey(Film.self, key: id.1.stringValue) == nil {
				let object = Film(value: ["id" : id.1.stringValue])
				realm.add(object, update: true)
			}
			array.append(realm.objectForPrimaryKey(Film.self, key: id.1.stringValue)!)
		}
		return List(array)
	}
	func createSpeciesList(json: JSON, realm: Realm) -> List<Species> {
		var array: [Species] = []
		for id in json {
			if realm.objectForPrimaryKey(Species.self, key: id.1.stringValue) == nil {
				let object = Species(value: ["id" : id.1.stringValue])
				realm.add(object, update: true)
			}
			array.append(realm.objectForPrimaryKey(Species.self, key: id.1.stringValue)!)
		}
		return List(array)
	}
	func createStarshipList(json: JSON, realm: Realm) -> List<Starship> {
		var array: [Starship] = []
		for id in json {
			if realm.objectForPrimaryKey(Starship.self, key: id.1.stringValue) == nil {
				let object = Starship(value: ["id" : id.1.stringValue])
				realm.add(object, update: true)
			}
			array.append(realm.objectForPrimaryKey(Starship.self, key: id.1.stringValue)!)
		}
		return List(array)
	}
	func createVehicleList(json: JSON, realm: Realm) -> List<Vehicle> {
		var array: [Vehicle] = []
		for id in json {
			if realm.objectForPrimaryKey(Vehicle.self, key: id.1.stringValue) == nil {
				let object = Vehicle(value: ["id" : id.1.stringValue])
				realm.add(object, update: true)
			}
			array.append(realm.objectForPrimaryKey(Vehicle.self, key: id.1.stringValue)!)
		}
		return List(array)
	}
	func createPlanetList(json: JSON, realm: Realm) -> List<Planet> {
		var array: [Planet] = []
		for id in json {
			if realm.objectForPrimaryKey(Planet.self, key: id.1.stringValue) == nil {
				let object = Planet(value: ["id" : id.1.stringValue])
				realm.add(object, update: true)
			}
			array.append(realm.objectForPrimaryKey(Planet.self, key: id.1.stringValue)!)
		}
		return List(array)
	}
}













