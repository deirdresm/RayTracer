//
//  TestCanvases.swift
//  RayTracerTests
//
//  Created by Deirdre Saoirse Moen on 3/24/19.
//  Copyright © 2019 Deirdre Saoirse Moen. All rights reserved.
//

import XCTest
@testable import RayTracer

class TestCanvases: XCTestCase {

//	Scenario​: Creating a canvas
//	​ 	  ​​ 	  ​Given​ c ← canvas(10, 20)
//	​ 	  ​​ 	  ​Then​ c.width = 10
//	​ 	    ​​ 	    ​And​ c.height = 20
//	​ 	    ​​ 	    ​And​ every pixel of c is color(0, 0, 0)

    func testCreateCanvas() {
		let c = Canvas(10,20)
		
		XCTAssertEqual(c.width, 10)
		XCTAssertEqual(c.height, 20)
		
		let black = Color(0, 0, 0)
		
		for y in 0..<c.width {
			for x in 0..<c.height {
				XCTAssertEqual(c.pixelAt(y, x), black)
			}
		}
    }
	
//	Scenario​: Writing pixels to a canvas
//	​      ​Given​ c ← canvas(10, 20)
//	​      ​And​ red ← color(1, 0, 0)
//	​      ​When​ write_pixel(c, 2, 3, red)
//	​  ​​    ​Then​ pixel_at(c, 2, 3) = red
	
	func testPixelSetAndRead() {
		let c = Canvas(10,20)
		let color = Color(1.0, 0.0, 0.0) // red
		print("color's redComponent: \(color.nsColor().redComponent), NSColor's redComponent: \((NSColor.red).redComponent)")
		
		XCTAssertEqual(color.red, 1.0)
		XCTAssertEqual(color.nsColor().redComponent, 1.0)
		
		XCTAssertEqual((NSColor.red).redComponent, color.nsColor().redComponent)
		
		c.writePixel(2, 3, color)
		XCTAssertEqual(c.pixelAt(2, 3).nsColor(), NSColor.red)

	}

}
