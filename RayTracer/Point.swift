//
//  Point.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 2/26/19.
//  Copyright © 2019 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name trailing_whitespace

class Point : Tuple {
	
	init(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat) {
		super.init(x, y, z, 1.0)
	}
	
	
	static func + (lhs: Point, rhs: Vector) -> Point {
		let x = lhs.x + rhs.x
		let y = lhs.y + rhs.y
		let z = lhs.z + rhs.z
		
		return Point(x, y, z)
	}
	
	override var description: String {
		return("Point: x: \(x), y: \(y), z: \(z), w: \(w)")
	}
}
