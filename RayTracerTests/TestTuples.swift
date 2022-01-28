//
//  TestTupleFeatures.swift
//
//  Created by Deirdre Saoirse Moen on 9/25/2018.
//  Copyright © 2018 Deirdre Saoirse Moen. All rights reserved.
//

import XCTest
@testable import RayTracer

// swiftlint:disable identifier_name

// TODO: Missing test cases
// 1. tuple x tuple
// 2. == that returns false
// 3. description
// 4. vector + vector
// 5. vector + point
// 6. vector += vector

class TestTupleFeatures: XCTestCase {

	// MARK: Tuples, Points, Vectors basics

	func testTupleW1isAPoint() {
		let point = Tuple(4.3, -4.2, 3.1, 1.0)
		XCTAssertEqual(point.x, 4.3)
		XCTAssertEqual(point.y, -4.2)
		XCTAssertEqual(point.z, 3.1)
		XCTAssertEqual(point.w, 1.0)

		XCTAssertTrue(point.isPoint())
		XCTAssertFalse(point.isVector())
	}

	func testTupleW0isAVector() {
		let vector = Tuple(4.3, -4.2, 3.1, 0.0)
		XCTAssertEqual(vector.x, 4.3)
		XCTAssertEqual(vector.y, -4.2)
		XCTAssertEqual(vector.z, 3.1)
		XCTAssertEqual(vector.w, 0.0)

		XCTAssertFalse(vector.isPoint())
		XCTAssertTrue(vector.isVector())
	}

	func testPointCreation() {
		let point = Point(4, -4, 3)

		XCTAssertTrue(abs(point.w - 1.0) < CGFloat.epsilon)
	}

	func testVectorCreation() {
		let vector = Vector(4, -4, 3)

		XCTAssertTrue(abs(vector.w) < CGFloat.epsilon)
	}

	// MARK: Tuple arithmetic

	func testTupleAddition() {
		let a1 = Tuple(3, -2, 5, 1)
		let a2 = Tuple(-2, 3, 1, 0)

		let a3 = a1 + a2
		let a4 = Tuple(1, 1, 6, 1)

		XCTAssertEqual(a3, a4)
	}

	func testPointSubtraction() {
		let a1 = Point(3, 2, 1)
		let a2 = Point(5, 6, 7)

		let a3 = a1 - a2
		let a4 = Vector(-2, -4, -6)

		XCTAssertEqual(a3, a4)
	}

	func testSubtractVectorFromPoint() {
		let p = Point(3, 2, 1)
		let v = Vector(5, 6, 7)

		XCTAssertEqual(p-v, Point(-2, -4, -6))
	}

	func testSubtractingTwoVectors() {
		let v1 = Vector(3, 2, 1)
		let v2 = Vector(5, 6, 7)

		XCTAssertEqual(v1-v2, Vector(-2, -4, -6))
	}

	func testSubtractVectorFromZero() {
		let zero = Vector(0, 0, 0)
		let v = Vector(1, -2, 3)

		XCTAssertEqual(zero-v, Vector(-1, 2,-3))
	}

	func testUnaryTupleNegation() {
		let a = Tuple(1, -2, 3, -4)

		XCTAssertEqual(-a, Tuple(-1, 2, -3, 4))
	}

	func testTupleTimesScalar() {
		let a = Tuple(1, -2, 3, -4)
		let b: CGFloat = 3.5

		XCTAssertEqual(a * b, Tuple(3.5, -7, 10.5, -14))
	}

	func testMultiplyTupleByFraction() {
		let a = Tuple(1, -2, 3, -4)
		let b: CGFloat = 0.5

		XCTAssertEqual(a * b, Tuple(0.5, -1, 1.5, -2))
	}

	func testDivideTupleByScalar() {
		let a = Tuple(1, -2, 3, -4)
		let b: CGFloat = 2.0

		XCTAssertEqual(a / b, Tuple(0.5, -1, 1.5, -2))
	}

	// MARK: M-m-m-Magnitude

	func testVectorMagnitude() {
		let v1 = Vector(1, 0, 0)
		XCTAssertEqual(v1.magnitude(), 1)

		let v2 = Vector(0, 1, 0)
		XCTAssertEqual(v2.magnitude(), 1)

		let v3 = Vector(0, 0, 1)
		XCTAssertEqual(v3.magnitude(), 1)

		let v4 = Vector(1, 2, 3)
		XCTAssertEqual(v4.magnitude(), sqrt(14.0))

		let v5 = Vector(-1, -2, -3)
		XCTAssertEqual(v5.magnitude(), sqrt(14.0))
	}

	func testNormalizedVector() {

		let sq: CGFloat = 1/sqrt(14)

		var v = Vector(4, 0, 0)
		XCTAssertEqual(v.normalize(), Vector(1, 0, 0))

		v = Vector(1, 2, 3)
		let normy = Vector(1*sq, 2*sq, 3*sq)
		XCTAssertEqual(v.normalize(), normy)

		XCTAssertEqual(normy.magnitude(), 1.0)
	}

	func testVectorDotProduct() {
		let a = Vector(1, 2, 3)
		let b = Vector(2, 3, 4)

		XCTAssertEqual(a • b, 20)
	}

	func testVectorCrossProduct() {
		let a = Vector(1, 2, 3)
		let b = Vector(2, 3, 4)

		XCTAssertEqual(a × b, Vector(-1, 2, -1))
		XCTAssertEqual(b × a, Vector(1, -2, 1))
	}

	// MARK: Color Tests

	func testColorSet() {
		let c = VColor(-0.5, 0.4, 1.7)

		XCTAssertEqual(c.red, -0.5)
		XCTAssertEqual(c.green, 0.4)
		XCTAssertEqual(c.blue, 1.7)
	}

	func testColorAddition() {
		let c1 = VColor(0.9, 0.6, 0.75)
		let c2 = VColor(0.7, 0.1, 0.25)

		XCTAssertEqual(c1 + c2, VColor(1.6, 0.7, 1.0))
	}

	func testColorSubtraction() {
		let c1 = VColor(0.9, 0.6, 0.75)
		let c2 = VColor(0.7, 0.1, 0.25)

		XCTAssertEqual(c1 - c2, VColor(0.2, 0.5, 0.5))
	}

	func testColorMultiplyByScalar() {
		let c = VColor(0.2, 0.3, 0.4)

		XCTAssertEqual(c * 2, VColor(0.4, 0.6, 0.8))
	}

	func testMultiplyingColors() {
		let c1 = VColor(1, 0.2, 0.4)
		let c2 = VColor(0.9, 1, 0.1)

		XCTAssertEqual(c1 * c2, VColor(0.9, 0.2, 0.04))
	}

	func testColorParameterClamping() {
		let c1 = VColor(1.5, 0, 0).clamped()
		let c2 = VColor(0.2, -0.5, 0.2).clamped()
		let c3 = VColor(-0.5, 0, 1).clamped()

		XCTAssertEqual(c1.clamped(), VColor(1.0, 0, 0))
		XCTAssertEqual(c2, VColor(0.2, 0, 0.2))
		XCTAssertEqual(c3, VColor(0, 0, 1))
	}

	// MARK: Reflection tests (Chapter 6.)

	//	Scenario: Reflecting a vector approaching at 45°
	//	Given v ← vector(1, -1, 0)
	//	And n ← vector(0, 1, 0)
	//	When r ← reflect(v, n)
	//	Then r = vector(1, 1, 0)

	func testReflectVectorApproachingAt45() {
		let v = Vector(1, -1, 0)
		let n = Vector(0,  1, 0)

		let r = v.reflect(n)
		XCTAssertEqual(r, Vector(1, 1, 0))
	}

	//	Scenario: Reflecting a vector off a slanted surface
	//	Given v ← vector(0, -1, 0)
	//	And n ← vector(√2/2, √2/2, 0)
	//	When r ← reflect(v, n)
	//	Then r = vector(1, 0, 0)

	func testReflectVectorOffSlantedSurface() {
		let v = Vector(0, -1, 0)
		let n = Vector(sqrt(2)/2, sqrt(2)/2, 0)

		let r = v.reflect(n)
		XCTAssertEqual(r, Vector(1, 0, 0))
	}

}
