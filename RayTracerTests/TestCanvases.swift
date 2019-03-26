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
	
	func testCanvasEquatability() {
		let c = Canvas(10, 20)
		let d = Canvas(10, 20)
		
		XCTAssertEqual(c, d)
		
		let red = Color(1.0, 0.0, 0.0) // red
		c.writePixel(2, 3, red)
		d.writePixel(2, 3, red)
		
		let blue = Color(0.0, 0.0, 1.0)
		c.writePixel(5, 9, blue)
		d.writePixel(5, 9, blue)
		
		XCTAssertEqual(c, d)
	}

}
