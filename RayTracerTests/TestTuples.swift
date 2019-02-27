//
//  TestTupleFeatures.swift
//
//  Created by Deirdre Saoirse Moen on 9/25/2018.
//  Copyright © 2018 Deirdre Saoirse Moen. All rights reserved.
//
import XCTest
@testable import RayTracer

class TestTupleFeatures: XCTestCase {
	
	let epsilon : Float = 0.00001

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
		let point = Tuple(x: 4.3, y: -4.2, z: 3.1, w: 1.0)
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
		let vector = Tuple(x: 4.3, y: -4.2, z: 3.1, w: 0.0)
		XCTAssertEqual(vector.x, 4.3)
		XCTAssertEqual(vector.y, -4.2)
		XCTAssertEqual(vector.z, 3.1)
		XCTAssertEqual(vector.w, 0.0)
		
		XCTAssertFalse(vector.isPoint())
		XCTAssertTrue(vector.isVector())
	}
	
	//Scenario​: point() creates tuples with w=1
	//​ 	  ​​ 	  ​Given​ p ← point(4, -4, 3)
	//​ 	  ​​ 	  ​Then​ p = tuple(4, -4, 3, 1)

	func testPointCreation() {
		let point = Point(x: 4, y: -4, z: 3)
		
		XCTAssertTrue(abs(point.w - 1.0) < epsilon)
	}
	
	//Scenario​: vector() creates tuples with w=0
	//​ 	  ​​ 	  ​Given​ v ← vector(4, -4, 3)
	//​ 	  ​​ 	  ​Then​ v = tuple(4, -4, 3, 0)

	
	func testVectorCreation() {
		let vector = Vector(x: 4, y: -4, z: 3)
		
		XCTAssertTrue(abs(vector.w) < epsilon)
	}
	
	//MARK: Tuple arithmetic
	
	// 	​Scenario​: Adding two tuples
	//​ 	  ​​ 	  ​Given​ a1 ← tuple(3, -2, 5, 1)
	//​ 	    ​​ 	    ​And​ a2 ← tuple(-2, 3, 1, 0)
	//​ 	   ​​ 	   ​Then​ a1 + a2 = tuple(1, 1, 6, 1)
	
	func testTupleAddition() {
		let a1 = Tuple(x: 3, y: -2, z: 5, w: 1)
		let a2 = Tuple(x: -2, y: 3, z: 1, w: 0)
		
		let a3 = a1 + a2
		let a4 = Tuple(x: 1, y: 1, z: 6, w: 1)
		
		XCTAssertEqual(a3, a4)
	}
	
	//Scenario​: Subtracting two points
	//​ 	  ​​ 	  ​Given​ p1 ← point(3, 2, 1)
	//​ 	    ​​ 	    ​And​ p2 ← point(5, 6, 7)
	//​ 	  ​​ 	  ​Then​ p1 - p2 = vector(-2, -4, -6)
	//Note: becomes a vector
	
	func testPointSubtraction() {
		let a1 = Point(x: 3, y: 2, z: 1)
		let a2 = Point(x: 5, y: 6, z: 7)
		
		let a3 = a1 - a2
		let a4 = Vector(x: -2, y: -4, z: -6)
		
		XCTAssertEqual(a3, a4)
	}



}
