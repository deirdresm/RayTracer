//
//  Tuple.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 2/26/19.
//  Copyright © 2019 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

class Tuple: Equatable, CustomStringConvertible {
	let epsilon : Float = 0.00001
	
	var x: Float
	var y: Float
	var z: Float
	var w: Float
	
	init(x: Float, y: Float, z: Float, w: Float) {
		self.x = x
		self.y = y
		self.z = z
		self.w = w
	}
	
	func isPoint() -> Bool {
		return abs(self.w - 1.0) < epsilon
	}

	func isVector() -> Bool {
		return abs(self.w) < epsilon
	}
	
	//MARK: Class Methods
	
	static func == (lhs: Tuple, rhs: Tuple) -> Bool {
		let epsilon : Float = 0.00001	// the other one's an instance method, and this is a class method

		if abs(lhs.x - rhs.x) <= epsilon &&
			abs(lhs.y - rhs.y) <= epsilon &&
			abs(lhs.z - rhs.z) <= epsilon &&
			abs(lhs.w - rhs.w) <= epsilon {

			return true
		}
		return false
	}
	
	static func + (lhs: Tuple, rhs: Tuple) -> Tuple {
		let x = lhs.x + rhs.x
		let y = lhs.y + rhs.y
		let z = lhs.z + rhs.z
		let w = lhs.w + rhs.w

		return Tuple(x: x, y: y, z: z, w: w)
	}
	
	static func - (lhs: Tuple, rhs: Tuple) -> Tuple {
		let x = lhs.x - rhs.x
		let y = lhs.y - rhs.y
		let z = lhs.z - rhs.z
		let w = lhs.w - rhs.w
		
		return Tuple(x: x, y: y, z: z, w: w)
	}

	
	//MARK: Custom Description
	
	var description: String {
		return("Tuple: x: \(x), y: \(y), z: \(z), w: \(w)")
	}
	
}
