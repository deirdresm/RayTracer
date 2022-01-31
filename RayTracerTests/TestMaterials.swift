//
//  TestMaterials.swift
//  RayTracerTests
//
//  Created by Deirdre Saoirse Moen on 1/22/22.
//  Copyright © 2022 Deirdre Saoirse Moen. All rights reserved.
//

import XCTest
@testable import RayTracer

class TestMaterials: XCTestCase {

//	Feature: Materials
//
//	Background:
//	  Given m ← material()
//		And position ← point(0, 0, 0)
//
//	Scenario: The default material
//	  Given m ← material()
//	  Then m.color = color(1, 1, 1)
//		And m.ambient = 0.1
//		And m.diffuse = 0.9
//		And m.specular = 0.9
//		And m.shininess = 200.0

	func testDefaultMaterial() {
		let m = Material()
		let c = VColor(1, 1, 1)

		XCTAssertEqual(m.color, c)
		XCTAssertEqual(m.ambient, 0.1)
		XCTAssertEqual(m.diffuse, 0.9)
		XCTAssertEqual(m.specular, 0.9)
		XCTAssertEqual(m.shininess, 200.0)
	}

//	Scenario: Reflectivity for the default material
//	  Given m ← material()
//	  Then m.reflective = 0.0

	func testDefaultMaterialReflectivity() {
		let m = Material()
		XCTAssertEqual(m.reflectivity, 0)
	}

//	Scenario: Transparency and Refractive Index for the default material
//	  Given m ← material()
//	  Then m.transparency = 0.0
//		And m.refractive_index = 1.0
// TODO: write this test when we get to this point

//	Scenario: Lighting with the eye between the light and the surface
//	  Given eyev ← vector(0, 0, -1)
//		And normalv ← vector(0, 0, -1)
//		And light ← point_light(point(0, 0, -10), color(1, 1, 1))
//	  When result ← lighting(m, light, position, eyev, normalv)
//	  Then result = color(1.9, 1.9, 1.9)

	func testLightingEyeInLightPath() {
		let m = Material()
		let position = Point(0, 0, 0)

		let eyeV = Vector(0, 0, -1)
		let normalV = Vector(0, 0, -1)

		let light = Light(position: Point(0, 0, -10), color: .white)
		let result = m.lighting(light: light, position: position, eyeV: eyeV, normalV: normalV)
		XCTAssertEqual(result, VColor(1.9, 1.9, 1.9))
	}

//	Scenario: Lighting with the eye between light and surface, eye offset 45°
//	  Given eyev ← vector(0, √2/2, -√2/2)
//		And normalv ← vector(0, 0, -1)
//		And light ← point_light(point(0, 0, -10), color(1, 1, 1))
//	  When result ← lighting(m, light, position, eyev, normalv)
//	  Then result = color(1.0, 1.0, 1.0)

	func testLightingOffset() {
		let m = Material()
		let position = Point(0, 0, 0)

		let eyeV = Vector(0, sqrt(2)/2, -sqrt(2)/2)
		let normalV = Vector(0, 0, -1)

		let light = Light(position: Point(0, 0, -10), color: .white)
		let result = m.lighting(light: light, position: position, eyeV: eyeV, normalV: normalV)
		XCTAssertEqual(result, .white)
	}

//	Scenario: Lighting with eye opposite surface, light offset 45°
//	  Given eyev ← vector(0, 0, -1)
//		And normalv ← vector(0, 0, -1)
//		And light ← point_light(point(0, 10, -10), color(1, 1, 1))
//	  When result ← lighting(m, light, position, eyev, normalv)
//	  Then result = color(0.7364, 0.7364, 0.7364)

	func testLightingOppositeSurface() {
		let m = Material()
		let position = Point(0, 0, 0)

		let eyeV = Vector(0, 0, -1)
		let normalV = Vector(0, 0, -1)

		let light = Light(position: Point(0, 10, -10), color: .white)
		let result = m.lighting(light: light, position: position, eyeV: eyeV, normalV: normalV)
		XCTAssertEqual(result, VColor(0.7364, 0.7364, 0.7364))
	}

//	Scenario: Lighting with eye in the path of the reflection vector
//	  Given eyev ← vector(0, -√2/2, -√2/2)
//		And normalv ← vector(0, 0, -1)
//		And light ← point_light(point(0, 10, -10), color(1, 1, 1))
//	  When result ← lighting(m, light, position, eyev, normalv)
//	  Then result = color(1.6364, 1.6364, 1.6364)

	func testLightingEyeInReflectionPath() {
		let m = Material()
		let position = Point(0, 0, 0)

		let eyeV = Vector(0, -sqrt(2)/2, -sqrt(2)/2)
		let normalV = Vector(0, 0, -1)

		let light = Light(position: Point(0, 10, -10), color: .white)
		let result = m.lighting(light: light, position: position, eyeV: eyeV, normalV: normalV)
		XCTAssertEqual(result, VColor(1.636396, 1.636396, 1.636396))

		// XCTAssertEqual failed: ("Point: x: 1.6363961030678928, y: 1.6363961030678928, z: 1.6363961030678928, w: 0.0") is not equal to ("Point: x: 1.63638, y: 1.63638, z: 1.63638, w: 0.0")
		// TODO: investigate above and why #s are that different.
	}

//	Scenario: Lighting with the light behind the surface
//	  Given eyev ← vector(0, 0, -1)
//		And normalv ← vector(0, 0, -1)
//		And light ← point_light(point(0, 0, 10), color(1, 1, 1))
//	  When result ← lighting(m, light, position, eyev, normalv)
//	  Then result = color(0.1, 0.1, 0.1)

	func testLightingLightBehindSurface() {
		let m = Material()
		let position = Point(0, 0, 0)

		let eyeV = Vector(0, 0, -1)
		let normalV = Vector(0, 0, -1)

		let light = Light(position: Point(0, 0, 10), color: .white)
		let result = m.lighting(light: light, position: position, eyeV: eyeV, normalV: normalV)
		XCTAssertEqual(result, VColor(0.1, 0.1, 0.1))
	}

//	Scenario: Lighting with the surface in shadow
//	  Given eyev ← vector(0, 0, -1)
//		And normalv ← vector(0, 0, -1)
//		And light ← point_light(point(0, 0, -10), color(1, 1, 1))
//		And in_shadow ← true
//	  When result ← lighting(m, light, position, eyev, normalv, in_shadow)
//	  Then result = color(0.1, 0.1, 0.1)
//
//	Scenario: Lighting with a pattern applied
//	  Given m.pattern ← stripe_pattern(color(1, 1, 1), color(0, 0, 0))
//		And m.ambient ← 1
//		And m.diffuse ← 0
//		And m.specular ← 0
//		And eyev ← vector(0, 0, -1)
//		And normalv ← vector(0, 0, -1)
//		And light ← point_light(point(0, 0, -10), color(1, 1, 1))
//	  When c1 ← lighting(m, light, point(0.9, 0, 0), eyev, normalv, false)
//		And c2 ← lighting(m, light, point(1.1, 0, 0), eyev, normalv, false)
//	  Then c1 = color(1, 1, 1)
//		And c2 = color(0, 0, 0)
}
