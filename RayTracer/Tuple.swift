//
//  Tuple.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 2/26/19.
//  Copyright © 2019 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name

infix operator •: MultiplicationPrecedence
infix operator ×: MultiplicationPrecedence

// TODO: consider making Tuple a struct

class Tuple: Equatable, CustomStringConvertible {
	let epsilon : CGFloat = 0.00001
	
	var x: CGFloat
	var y: CGFloat
	var z: CGFloat
	var w: CGFloat
	
    init(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat, _ w: CGFloat) {
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
		let epsilon : CGFloat = 0.00001	// the other one's an instance method, and this is a class method

		if abs(lhs.x - rhs.x) <= epsilon &&
			abs(lhs.y - rhs.y) <= epsilon &&
			abs(lhs.z - rhs.z) <= epsilon &&
			abs(lhs.w - rhs.w) <= epsilon {

			return true
		}
		return false
	}
	
	static func + (lhs: Tuple, rhs: Tuple) -> some Tuple {
		let x = lhs.x + rhs.x
		let y = lhs.y + rhs.y
		let z = lhs.z + rhs.z
		let w = lhs.w + rhs.w

		return Tuple(x, y, z, w)
	}
	
	static func - (lhs: Tuple, rhs: Tuple) -> some Tuple {
		let x = lhs.x - rhs.x
		let y = lhs.y - rhs.y
		let z = lhs.z - rhs.z
		let w = lhs.w - rhs.w
		
		return Tuple(x, y, z, w)
	}

	static func * (lhs: Tuple, rhs: CGFloat) -> some Tuple {
		let x = lhs.x * rhs
		let y = lhs.y * rhs
		let z = lhs.z * rhs
		let w = lhs.w * rhs
		
		return Tuple(x, y, z, w)
	}

	static func * (lhs: Tuple, rhs: Tuple) -> some Tuple {
		let x = lhs.x * rhs.x
		let y = lhs.y * rhs.y
		let z = lhs.z * rhs.z
		let w = lhs.w * rhs.w
		
		return Tuple(x, y, z, w)
	}
	
	static func / (lhs: Tuple, rhs: CGFloat) -> some Tuple {
		let x = lhs.x / rhs
		let y = lhs.y / rhs
		let z = lhs.z / rhs
		let w = lhs.w / rhs
		
		return Tuple(x, y, z, w)
	}

	// unary minus operator e.g., -tuple
	
	public static prefix func - (_ tuple: Tuple) -> Tuple {
		let result = Tuple(-(tuple.x), -(tuple.y), -(tuple.z), -(tuple.w))
		
		return result
	}
	
	// MARK: Magnitude functions
	
	public func magnitude() -> CGFloat {
		let mag = sqrt(self.x*self.x + self.y*self.y + self.z*self.z + self.w*self.w)
		return mag
	}
	
	public func normalize() -> Tuple {
		
		let magSquared = self.x*self.x + self.y*self.y + self.z*self.z + self.w*self.w
		let sq = 1.0/sqrt(magSquared)
		
		let normal = Tuple(self.x*sq, self.y*sq, self.z*sq, self.w*sq)
		
		return normal
	}
	
	// Dot product (note: using option-8 for this dot as the right dot has another meaning?)
	
	public static func • (_ left: Tuple, _ right: Tuple) -> CGFloat {
		let result = left.x * right.x + left.y * right.y +
					left.z * right.z + left.w * right.w
		return result
	}
	
	// Cross product (using × as the operator)
	
	public static func × (_ a: Tuple, _ b: Tuple) -> Tuple {
		
		return Tuple(a.y * b.z - a.z * b.y,
					a.z * b.x - a.x * b.z,
					a.x * b.y - a.y * b.x,
					0.0)
	}
	
	//MARK: Custom Description
	
	var description: String {
		return("Tuple: x: \(x), y: \(y), z: \(z), w: \(w)")
	}
	
}


