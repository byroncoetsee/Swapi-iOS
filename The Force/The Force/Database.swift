//
//  Database.swift
//  The Force
//
//  Created by Byron Coetsee on 2016/09/01.
//  Copyright © 2016 Byron Coetsee. All rights reserved.
//

import Foundation
import RealmSwift

// Realm won't persist these
//class Database: Object {
//	override static func ignoredProperties() -> [String] {
//		return ["Film"]
//	}
//}


class Film: Object {
	var id: String!
	var name: String!
	var episodeId: Int!
	var openingCrawl: String!
	var director: String!
	var producer: String!
	var releaseDate: NSDate!
	
	var characters = List<Character>()
	var speciess = List<Species>() // Awesome english right there...
	var starships = List<Starship>()
	var vehicles = List<Vehicle>()
	var planets = List<Planet>()
	
	override class func primaryKey() -> String? { return "id" }
}

class Character: Object {
	var id: String!
	var name: String!
	var birthdate: Int! // <0 = Before Battle of Y... (BBY). 0. >0 = After Battle of Y... (ABY)
	var eyeColour: String? // Nil = unknown or n/a
	var gender: Bool? // True = male, false = femail, nil = unknown or n/a
	var hairColour: String?
	var height: Int! // Centimeters
	var mass: Double!
	var skinColour: String!
	var homeWorld = LinkingObjects(fromType: Planet.self, property: "residents")
	
	var films = List<Film>()
	var speciess = List<Species>()
	var starships = List<Starship>()
	var vehicles = List<Vehicle>()
	
	override class func primaryKey() -> String? { return "id" }
}

class Planet: Object {
	var id: String!
	var name: String!
	var diameter: Int! // Kilometers
	var rotationPeriod: Int! // Hours
	var orbitalPeriod: String! // Days
	var gravity: Double! // 1 = 1G on earth
	var population: Int!
	var climate: String!
	var terrain: String!
	var water: Double! // Percentage of surface is water
	
	var residents = List<Character>()
	var films = List<Film>()
	
	override class func primaryKey() -> String? { return "id" }
}

class Species: Object {
	var id: String!
	var name: String!
	var classification: String!
	var designation: String!
	var height: Int!
	var lifespan: Int!
	var eyeColoure: String!
	var skinColours: String!
	var language: String!
	var homeWorld: Planet!
	
	var characters = List<Character>()
	var films = List<Film>()
	
	override class func primaryKey() -> String? { return "id" }
}

class Starship: Object {
	var id: String!
	var name: String!
	var model: String!
	var manufacturer: String!
	var cost: Double!
	var length: Int!
	var crew: Int!
	var passengers: Int!
	var speed_atmosphere: Int?
	var hyperdriveRating: Double!
	var MGLT: Double!
	var cargoCapacity: Double!
	var consumables: String!
	
	var films = List<Film>()
	var pilots = List<Character>()
	
	override class func primaryKey() -> String? { return "id" }
}

class Vehicle: Object {
	var id: String!
	var name: String!
	var model: String!
	var vehicleClass: String!
	var manufacturer: String!
	var cost: Double!
	var length: Int!
	var crew: Int!
	var passengers: Int!
	var speed_atmosphere: Int?
	var cargoCapacity: Double!
	var consumables: String!
	
	var films = List<Film>()
	var pilots = List<Character>()
	
	override class func primaryKey() -> String? { return "id" }
}
