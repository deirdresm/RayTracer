//
//  SampleShape.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 1/30/22.
//  Copyright © 2022 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

class SampleShape: Shape, Equatable {

	var id = UUID()
	var material: Material
	var description: String = ""
	var transform: Matrix

	public required init(material: Material, transform: Matrix = Matrix.identity) {
		self.material = material
		self.transform = transform
	}

	func intersections(_ ray: Ray) -> [Intersection] {
		let localRay = ray.transform(transform.inverse)
		return []
	}

	func normal(at worldPoint: Point) -> Vector {
		return Vector(0, 0, 0)
	}

	static func == (lhs: SampleShape, rhs: SampleShape) -> Bool {
		return lhs.id == rhs.id
	}
}
