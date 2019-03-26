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
			255

			"""

        let c = Canvas(5,3)
		let ppm = c.toPPM()
		
		XCTAssertEqual(ppm, header)
		
    }

	func testExample() {
		
	}
	
	func testExample2() {
		
	}
	
}
