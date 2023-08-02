//
//  TestLights.swift
//  RayTracerTests
//
//  Created by Deirdre Saoirse Moen on 1/22/22.
//  Copyright © 2022 Deirdre Saoirse Moen. All rights reserved.
//

import XCTest
@testable import RayTracer

class TestLights: XCTestCase {

//	Feature: Lights
//	
//	Scenario: A point light has a position and intensity
//	  Given intensity ← color(1, 1, 1)
//		And position ← point(0, 0, 0)
//	  When light ← point_light(position, intensity)
//	  Then light.position = position
//		And light.intensity = intensity

	func testLightHasPositionAndIntensity() {
		let color = VColor(1, 1, 1)
		let position = Point(0, 0, 0)

		let light = Light(position: position, color: color)

		XCTAssertEqual(light.position, position)
		XCTAssertEqual(light.color, color)
	}

	// There wasn't a test for the rest of the lighting function, soooooo
	func testPointLightLighting() {
		let material = Material(color: .white)
		let position = Point(0, 0, 0)
		let eyeV = Vector(0, 0, -1)
		let normalV = Vector(0, 0, -1)
		let light = Light(position: Point(-1, 10, -5), color: VColor(0.2, 0.5, 0.75))

		let ml = material.lighting(light: light, position: position, eyeV: eyeV, normalV: normalV)

		// TODO: Missing testPointLightLighting test.
	}
}
