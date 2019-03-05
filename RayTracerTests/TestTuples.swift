//
//  TestTupleFeatures.swift
//
//  Created by Deirdre Saoirse Moen on 9/25/2018.
//  Copyright © 2018 Deirdre Saoirse Moen. All rights reserved.
//
import XCTest
@testable import RayTracer

class TestTupleFeatures: XCTestCase {
	
	let epsilon : Double = 0.00001
	
	//MARK: Tuples, Points, Vectors basics

	//Feature: Tuples
	//
	//Scenario​: ​A ​tuple with w=1.0 is a point
	//​  ​Given ​a ← tuple(4.3, -4.2, 3.1, 1.0)
	//​  ​Then ​a.x = 4.3
	//​  ​And ​a.y = -4.2
	//​    ​And ​a.z = 3.1
	//​    ​And ​a.w = 1.0
	//​    ​And ​a is a point
	//​    ​And ​a is not a vector
	
	func testTupleW1isAPoint() {
		let point = Tuple(4.3, -4.2, 3.1, 1.0)
		XCTAssertEqual(point.x, 4.3)
		XCTAssertEqual(point.y, -4.2)
		XCTAssertEqual(point.z, 3.1)
		XCTAssertEqual(point.w, 1.0)

		XCTAssertTrue(point.isPoint())
		XCTAssertFalse(point.isVector())
	}
	
	//​​Scenario​: ​A ​tuple with w=0 is a vector
	//​  ​Given ​a ← tuple(4.3, -4.2, 3.1, 0.0)
	//​  ​Then ​a.x = 4.3
	//​    ​And ​a.y = -4.2
	//​    ​And ​a.z = 3.1
	//​    ​And ​a.w = 0.0
	//​    ​And ​a is not a point
	//​    ​And ​a is a vect

	func testTupleW0isAVector() {
		let vector = Tuple(4.3, -4.2, 3.1, 0.0)
		XCTAssertEqual(vector.x, 4.3)
		XCTAssertEqual(vector.y, -4.2)
		XCTAssertEqual(vector.z, 3.1)
		XCTAssertEqual(vector.w, 0.0)
		
		XCTAssertFalse(vector.isPoint())
		XCTAssertTrue(vector.isVector())
	}
	
	//Scenario​: point() creates tuples with w=1
	//​	  ​​	  ​Given​ p ← point(4, -4, 3)
	//​	  ​​	  ​Then​ p = tuple(4, -4, 3, 1)

	func testPointCreation() {
		let point = Point(4, -4, 3)
		
		XCTAssertTrue(abs(point.w - 1.0) < epsilon)
	}
	
	//Scenario​: vector() creates tuples with w=0
	//​	  ​​	  ​Given​ v ← vector(4, -4, 3)
	//​	  ​​	  ​Then​ v = tuple(4, -4, 3, 0)

	
	func testVectorCreation() {
		let vector = Vector(4, -4, 3)
		
		XCTAssertTrue(abs(vector.w) < epsilon)
	}
	
	//MARK: Tuple arithmetic
	
	//	​Scenario​: Adding two tuples
	//​	  ​​	  ​Given​ a1 ← tuple(3, -2, 5, 1)
	//​	    ​​	    ​And​ a2 ← tuple(-2, 3, 1, 0)
	//​	   ​​	   ​Then​ a1 + a2 = tuple(1, 1, 6, 1)
	
	func testTupleAddition() {
		let a1 = Tuple(3, -2, 5, 1)
		let a2 = Tuple(-2, 3, 1, 0)
		
		let a3 = a1 + a2
		let a4 = Tuple(1, 1, 6, 1)
		
		XCTAssertEqual(a3, a4)
	}
	
	//Scenario​: Subtracting two points
	//​	  ​​	  ​Given​ p1 ← point(3, 2, 1)
	//​	    ​​	    ​And​ p2 ← point(5, 6, 7)
	//​	  ​​	  ​Then​ p1 - p2 = vector(-2, -4, -6)
	//Note: becomes a vector
	
	func testPointSubtraction() {
		let a1 = Point(3, 2, 1)
		let a2 = Point(5, 6, 7)
		
		let a3 = a1 - a2
		let a4 = Vector(-2, -4, -6)
		
		XCTAssertEqual(a3, a4)
	}

	//	Scenario​: Subtracting a vector from a point
	//​	  ​​	  ​Given​ p ← point(3, 2, 1)
	//​	    ​​	    ​And​ v ← vector(5, 6, 7)
	//​	  ​​	  ​Then​ p - v = point(-2, -4, -6)


	func testSubtractVectorFromPoint() {
		let p = Point(3, 2, 1)
		let v = Vector(5, 6, 7)
		
		XCTAssertEqual(p-v, Point(-2, -4, -6))
	}

	//	Scenario​: Subtracting two vectors
	//​	  ​​	  ​Given​ v1 ← vector(3, 2, 1)
	//​	    ​​	    ​And​ v2 ← vector(5, 6, 7)
	//​	  ​​	  ​Then​ v1 - v2 = vector(-2, -4, -6)

	func testSubtractingTwoVectors() {
		let v1 = Vector(3, 2, 1)
		let v2 = Vector(5, 6, 7)
		
		XCTAssertEqual(v1-v2, Vector(-2, -4, -6))
	}
	
	//	Scenario​: Subtracting a vector from the zero vector
	//​	  ​​	  ​Given​ zero ← vector(0, 0, 0)
	//​	    ​​	    ​And​ v ← vector(1, -2, 3)
	//​	  ​​	  ​Then​ zero - v = vector(-1, 2, -3)
	
	func testSubtractVectorFromZero() {
		let zero = Vector(0, 0, 0)
		let v = Vector(1, -2, 3)
		
		XCTAssertEqual(zero-v, Vector(-1, 2,-3))

	}

	//	Scenario​: Negating a tuple
	//​	  ​​	  ​Given​ a ← tuple(1, -2, 3, -4)
	//​	  ​​	  ​Then​ -a = tuple(-1, 2, -3, 4)
	
	// Note: In Swift, need to create the method
	
	func testUnaryTupleNegation() {
		let a = Tuple(1, -2, 3, -4)
		
		XCTAssertEqual(-a, Tuple(-1, 2, -3, 4))

	}
	
	//	Scenario​: Multiplying a tuple by a scalar
	//​	  Given​ a ← tuple(1, -2, 3, -4)
	//​	  ​​Then​ a * 3.5 = tuple(3.5, -7, 10.5, -14)

	func testTupleTimesScalar() {
		let a = Tuple(1, -2, 3, -4)
		let b : Double = 3.5
		
		XCTAssertEqual(a * b, Tuple(3.5, -7, 10.5, -14))
	}

	//	Scenario​: Multiplying a tuple by a fraction
	//​	 	 ​Given​ a ← tuple(1, -2, 3, -4)
	//​		 Then​ a * 0.5 = tuple(0.5, -1, 1.5, -2)

	func testMultiplyTupleByFraction() {
		let a = Tuple(1, -2, 3, -4)
		let b : Double = 0.5

		XCTAssertEqual(a * b, Tuple(0.5, -1, 1.5, -2))
	}
	
	//	Scenario: Dividing a tuple by a scalar
	//		Given a ← tuple(1, -2, 3, -4)
	//		Then a / 2 = tuple(0.5, -1, 1.5, -2)
	
	
	func testDivideTupleByScalar() {
		let a = Tuple(1, -2, 3, -4)
		let b : Double = 2.0
		
		XCTAssertEqual(a / b, Tuple(0.5, -1, 1.5, -2))
	}
	
	// MARK: M-m-m-Magnitude
	
	//	Scenario: Magnitude of vector(1, 0, 0)
	//	Given v ← vector(1, 0, 0)
	//	Then magnitude(v) = 1
	//
	//	Scenario: Magnitude of vector(0, 1, 0)
	//	Given v ← vector(0, 1, 0)
	//	Then magnitude(v) = 1
	//
	//	Scenario: Magnitude of vector(0, 0, 1)
	//	Given v ← vector(0, 0, 1)
	//	Then magnitude(v) = 1
	
	//	Scenario: Magnitude of vector(1, 2, 3)
	//	Given v ← vector(1, 2, 3)
	//	Then magnitude(v) = √14
	//
	//	Scenario: Magnitude of vector(-1, -2, -3)
	//	Given v ← vector(-1, -2, -3)
	//	Then magnitude(v) = √14
	
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

	
	//	Scenario: Normalizing vector(4, 0, 0) gives (1, 0, 0)
	//	Given v ← vector(4, 0, 0)
	//	Then normalize(v) = vector(1, 0, 0)
	//
	//	Scenario: Normalizing vector(1, 2, 3)
	//	Given v ← vector(1, 2, 3)
	//	# vector(1/√14,   2/√14,   3/√14)
	//	Then normalize(v) = approximately vector(0.26726, 0.53452, 0.80178)
	//
	//	Scenario: The magnitude of a normalized vector
	//	Given v ← vector(1, 2, 3)
	//	When norm ← normalize(v)
	//	Then magnitude(norm) = 1

	func testNormalizedVector() {
		
		let sq : Double = 1/sqrt(14)
		
		var v = Vector(4, 0, 0)
		XCTAssertEqual(v.normalize(), Vector(1, 0, 0))
		
		v = Vector(1, 2, 3)
		let normy = Vector(1*sq, 2*sq, 3*sq)
		XCTAssertEqual(v.normalize(), normy)
		
		XCTAssertEqual(normy.magnitude(), 1.0)
	}

	//	Scenario: The dot product of two tuples
	//	Given a ← vector(1, 2, 3)
	//	And b ← vector(2, 3, 4)
	//	Then a dot b = 20

	func testVectorDotProduct() {
		let a = Vector(1, 2, 3)
		let b = Vector(2, 3, 4)
		
		XCTAssertEqual(a • b, 20)
	}

	
	//	Scenario: Cross product of two vectors
	//	Given a ← vector(1, 2, 3)
	//	And b ← vector(2, 3, 4)
	//	Then a cross b = vector(-1, 2, -1)
	//	And b cross a = vector(1, -2, 1)
	//
	
	func testVectorCrossProduct() {
		let a = Vector(1, 2, 3)
		let b = Vector(2, 3, 4)
		
		XCTAssertEqual(a × b, Vector(-1, 2, -1))
		XCTAssertEqual(b × a, Vector(1, -2, 1))
	}


	// TODO: Not-yet-implemented tests

	//×
	//	Scenario: Colors are (red, green, blue) tuples
	//	Given c ← color(-0.5, 0.4, 1.7)
	//	Then c.red = -0.5
	//	And c.green = 0.4
	//	And c.blue = 1.7
	
	func testColorSet() {
		let c = Color(-0.5, 0.4, 1.7)
		
		XCTAssertEqual(c.red, -0.5)
		XCTAssertEqual(c.green, 0.4)
		XCTAssertEqual(c.blue, 1.7)
	}
	
	//	Scenario: Adding colors
	//	Given c1 ← color(0.9, 0.6, 0.75)
	//	And c2 ← color(0.7, 0.1, 0.25)
	//	Then c1 + c2 = color(1.6, 0.7, 1.0)

	func testColorAddition() {
		let c1 = Color(0.9, 0.6, 0.75)
		let c2 = Color(0.7, 0.1, 0.25)

		XCTAssertEqual(c1 + c2, Color(1.6, 0.7, 1.0))
	}

	//	Scenario: Subtracting colors
	//	Given c1 ← color(0.9, 0.6, 0.75)
	//	And c2 ← color(0.7, 0.1, 0.25)
	//	Then c1 - c2 = color(0.2, 0.5, 0.5)

	func testColorSubtraction() {
		let c1 = Color(0.9, 0.6, 0.75)
		let c2 = Color(0.7, 0.1, 0.25)
		
		XCTAssertEqual(c1 - c2, Color(0.2, 0.5, 0.5))
	}

	//	Scenario: Multiplying a color by a scalar
	//	Given c ← color(0.2, 0.3, 0.4)
	//	Then c * 2 = color(0.4, 0.6, 0.8)

	func testColorMultiplyByScalar() {
		let c = Color(0.2, 0.3, 0.4)
		
		XCTAssertEqual(c * 2, Color(0.4, 0.6, 0.8))
	}
	
	//	Scenario: Multiplying colors
	//	Given c1 ← color(1, 0.2, 0.4)
	//	And c2 ← color(0.9, 1, 0.1)
	//	Then c1 * c2 = color(0.9, 0.2, 0.04)

	func testMultiplyingColors() {
		let c1 = Color(1, 0.2, 0.4)
		let c2 = Color(0.9, 1, 0.1)
		
		XCTAssertEqual(c1 * c2, Color(0.9, 0.2, 0.04))
	}
	
	// MARK: Reflection tests
	
	//	Scenario: Reflecting a vector approaching at 45°
	//	Given v ← vector(1, -1, 0)
	//	And n ← vector(0, 1, 0)
	//	When r ← reflect(v, n)
	//	Then r = vector(1, 1, 0)
	//
	//	Scenario: Reflecting a vector off a slanted surface
	//	Given v ← vector(0, -1, 0)
	//	And n ← vector(√2/2, √2/2, 0)
	//	When r ← reflect(v, n)
	//	Then r = vector(1, 0, 0)

	

}
