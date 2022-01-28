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

/// Tuple: parent class for Point and Vector.

extension CGFloat {
	public static let epsilon: CGFloat = 0.00001
}

public class Tuple: Equatable, CustomStringConvertible {
	var x: CGFloat
	var y: CGFloat
	var z: CGFloat
	var w: CGFloat

    required init(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat, _ w: CGFloat) {
		self.x = x
		self.y = y
		self.z = z
		self.w = w
	}

	func isPoint() -> Bool {
		return abs(self.w - 1.0) < CGFloat.epsilon
	}

	func isVector() -> Bool {
		return abs(self.w) < CGFloat.epsilon
	}

	// MARK: Class Methods

	// MARK: Magnitude functions

	public func magnitude() -> CGFloat {
		let mag = sqrt(self.x*self.x + self.y*self.y + self.z*self.z + self.w*self.w)
		return mag
	}

	public func normalize<T: Tuple>() -> T {
		let magSquared = self.x*self.x + self.y*self.y + self.z*self.z + self.w*self.w
		let sq = 1.0/sqrt(magSquared)

		let normal = T(self.x*sq, self.y*sq, self.z*sq, self.w*sq)

		return normal
	}

	// Reflect!

	public func reflect<T: Tuple>(_ normal: T) -> T {
		return self - normal * 2 * (self • normal)
	}

	/// Custom Description
	public var description: String {
		return("Tuple: x: \(x), y: \(y), z: \(z), w: \(w)")
	}
}

/// MARK: - Unary operators

/// Add Tuple + CGFloat together, returning result
func + <T: Tuple>(lhs: Tuple, rhs: CGFloat) -> T {
	let x = lhs.x + rhs
	let y = lhs.y + rhs
	let z = lhs.z + rhs
	let w = lhs.w + rhs

	return T(x, y, z, w)
}

/// Add two tuples together, returning the result
func + <T: Tuple>(lhs: Tuple, rhs: Tuple) -> T {
	let x = lhs.x + rhs.x
	let y = lhs.y + rhs.y
	let z = lhs.z + rhs.z
	let w = lhs.w + rhs.w

	return T(x, y, z, w)
}

/// Subtract rhs tuple from lhs, returning the result
func - <T: Tuple>(lhs: Tuple, rhs: Tuple) -> T {
	let x = lhs.x - rhs.x
	let y = lhs.y - rhs.y
	let z = lhs.z - rhs.z
	let w = lhs.w - rhs.w

	return T(x, y, z, w)
}

/// Multiply a tuple by a float, returning the result
func * <T: Tuple>(lhs: Tuple, rhs: CGFloat) -> T {
	let x = lhs.x * rhs
	let y = lhs.y * rhs
	let z = lhs.z * rhs
	let w = lhs.w * rhs

	return T(x, y, z, w)
}

/// Multiply two tuples together, returning the result
func * <T: Tuple>(lhs: T, rhs: Tuple) -> T {
	let x = lhs.x * rhs.x
	let y = lhs.y * rhs.y
	let z = lhs.z * rhs.z
	let w = lhs.w * rhs.w

	return T(x, y, z, w)
}

/// Divide a tuple by a float, returning the result
func / <T: Tuple>(lhs: T, rhs: CGFloat) -> T {
	let x = lhs.x / rhs
	let y = lhs.y / rhs
	let z = lhs.z / rhs
	let w = lhs.w / rhs

	return T(x, y, z, w)
}

/// unary minus operator e.g., -tuple
prefix func - <T: Tuple>(_ tuple: Tuple) -> T {
	let result = T(-(tuple.x), -(tuple.y), -(tuple.z), -(tuple.w))

	return result
}

public func == <T: Tuple>(lhs: T, rhs: T) -> Bool {
	let epsilon: CGFloat = 0.00001	// the other one's an instance method, and this is a class method

	if abs(lhs.x - rhs.x) <= CGFloat.epsilon &&
		abs(lhs.y - rhs.y) <= CGFloat.epsilon &&
		abs(lhs.z - rhs.z) <= CGFloat.epsilon &&
		abs(lhs.w - rhs.w) <= CGFloat.epsilon {

		return true
	}
	return false
}

// Cross product (using × as the operator)

func × <T: Tuple>(_ a: T, _ b: T) -> T {

	return T(a.y * b.z - a.z * b.y,
			a.z * b.x - a.x * b.z,
			a.x * b.y - a.y * b.x,
			0.0)
}

// Dot product (note: using option-8 for this dot as the right dot has another meaning?)

func • <T: Tuple>(_ left: T, _ right: T) -> CGFloat {
	let result = left.x * right.x + left.y * right.y +
			   left.z * right.z + left.w * right.w
	return result
}
