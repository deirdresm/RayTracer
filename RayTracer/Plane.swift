//
//  Plane.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 1/28/22.
//  Copyright © 2022 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

class Plane: Shape {
	var id = UUID()
	var material: Material

	init(_ material: Material) {
		self.material = material
	}

	var description: String {
		return "I'm on a chair in the sky."
	}

	func intersections(_ ray: Ray) -> [Intersection] {
		if abs(ray.direction.y) >= CGFloat.epsilon {
			return [Intersection(distance: -ray.origin.y / ray.direction.y, shape: self)]
		} else {
			return []
		}
	}

	func normal(at worldPoint: Point) -> Vector {
		return Vector(0, 1, 0)
	}

}
