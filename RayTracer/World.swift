//
//  World.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 1/24/22.
//  Copyright © 2022 Deirdre Saoirse Moen. All rights reserved.
//

// starting in Chapter 7
import Foundation

class World {
	var objects: [Shape]
	var lights: [Light]

	required init(objects: [Shape] = [], lights: [Light] = []) {
		self.objects = objects
		self.lights = lights
	}

	func defaultWorld() {
		let light = Light(position: Point(10, -10, 10), intensity: .white)
		lights.append(light)
	}

	func intersections(ray: Ray) -> [Intersection] {
		var intersections = [Intersection]()

		for object in objects {
			let xs = object.intersections(ray)
			intersections += xs
		}

		return intersections.sorted()
	}

}
