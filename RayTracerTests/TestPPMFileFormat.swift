//
//  TestPPMFileFormat.swift
//  RayTracerTests
//
//  Created by Deirdre Saoirse Moen on 3/25/19.
//  Copyright © 2019 Deirdre Saoirse Moen. All rights reserved.
//

import XCTest
@testable import RayTracer

class TestPPMFileFormat: XCTestCase {
	
//	Scenario​: Constructing the PPM header
//	​ 	  ​​ 	  ​Given​ c ← canvas(5, 3)
//	When​ ppm ← canvas_to_ppm(c)
//	​ 	  ​​ 	  ​Then​ lines 1-3 of ppm are
//	​ 	    ​​ 	    ​"""
//	​ 	​    ​ 	​    P3
//	​ 	​    ​ 	​    5 3
//	​ 	​    ​ 	​    255
//	​ 	​    ​ 	​    """

    func testPPMHeader() {
		
		let header =
			"""
			P3
			5 3
			255\n
			"""

        let c = Canvas(5,3)
		let ppm = c.toPPM()
		
		XCTAssertTrue(ppm.hasPrefix(header))
    }
	
	func testPPMPixelData() {
		let header =
		"""
			P3
			5 3
			255\n
			"""
		
		let body =
		"""
			255 0 0 0 0 0 0 0 0 0 0 0 0 0 0
			0 0 0 0 0 0 0 128 0 0 0 0 0 0 0
			0 0 0 0 0 0 0 0 0 0 0 0 0 0 255\n
			"""

		let c = Canvas(5,3)
		
		let c1 = Color(1.5, 0, 0).clamped()
		let c2 = Color(0.2, -0.5, 0.2).clamped()
		let c3 = Color(-0.5, 0, 1).clamped()
		
		c.writePixel(0, 0, c1)
		c.writePixel(2, 1, c2)
		c.writePixel(4, 2, c3)

		let ppm = c.toPPM()
		let ppmExpected = header + body
		
		print(body)
		
		XCTAssertTrue(ppm.hasPrefix(header))
		XCTAssertTrue(ppm.hasSuffix(body))
	}
	
	func testExample2() {
		
	}
	
}
