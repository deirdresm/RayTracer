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
		let intensity = VColor(1, 1, 1)
		let position = Point(0, 0, 0)

		let light = Light(position: position, intensity: intensity)

		XCTAssertEqual(light.position, position)
		XCTAssertEqual(light.intensity, intensity)
	}
}
