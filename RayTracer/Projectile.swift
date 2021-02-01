//
//  Projectile.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 4/6/19.
//  Copyright © 2019 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

struct Projectile {
	var position = Point(0, 0, 0)
	var velocity = Vector(0, 0, 0)
	
	mutating func tick(environment: Environment) {
		position = position + velocity
		velocity = velocity + environment.gravity + environment.wind
	}
}

struct Environment {
	var gravity = Vector(0, 0, 0)
	var wind = Vector(0, 0, 0)
}
