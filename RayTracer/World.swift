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

	func intersections(ray: Ray) -> [Intersection] {
		var intersections = [Intersection]()

		for object in objects {
			let xs = object.intersections(ray)
			intersections += xs
		}

		return intersections.sorted()
	}

	func shadeHit(with intersectionState: IntersectionState) -> VColor {
		// support multiple lights at this intersection
		return lights.reduce(into: VColor.black) { result, light in
			result = result + intersectionState.shape.material.lighting(light: light,
							position: intersectionState.point,
							eyeV: intersectionState.eyeV,
							normalV: intersectionState.normalV)
		}
	}

	public func color(at ray: Ray) -> VColor {
		let xs = intersections(ray: ray)

		guard let hit = Intersection.hit(by: xs) else {
			return .black
		}
		return shadeHit(with: IntersectionState(intersection: hit, ray: ray))
	}
}

#if DEBUG
extension World {
	static func defaultWorld() -> World {
		let world = World()
		let light = Light(position: Point(-10, 10, -10), color: .white)
		world.lights.append(light)

		let sphereOne = Sphere()
		var material = Material(diffuse: 0.7, specular: 0.2, color: VColor(0.8, 1.0, 0.6))
		sphereOne.material = material

		var sphereTwo = Sphere()
		sphereTwo.setTransform(Matrix.scaling(point: Point(0.5, 0.5, 0.5)))

		world.objects = [sphereOne, sphereTwo]

		return world
	}

}
#endif
