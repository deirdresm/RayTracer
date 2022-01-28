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

		let black = VColor(0, 0, 0)

		for y in 0..<c.height {
			for x in 0..<c.width {
				XCTAssertEqual(c.pixel(at: x, y), black)
			}
		}
    }

	func testPixelSetAndRead() {
		let c = Canvas(10,20)
		let color = VColor(1.0, 0.0, 0.0) // red

		XCTAssertEqual(color.red, 1.0)
		XCTAssertEqual(color.nsColor().redComponent, 1.0)

		XCTAssertEqual((NSColor.red).redComponent, color.nsColor().redComponent)

		c.writePixel(2, 3, color)
		XCTAssertEqual(c.pixel(at: 2, 3).nsColor(), NSColor.red)
	}

	func testCanvasEquatability() {
		let c = Canvas(10, 20)
		let d = Canvas(10, 20)

		XCTAssertEqual(c, d)

		let red = VColor(1.0, 0.0, 0.0) // red
		c.writePixel(2, 3, red)
		d.writePixel(2, 3, red)

		let blue = VColor(0.0, 0.0, 1.0)
		c.writePixel(5, 12, blue)
		d.writePixel(5, 12, blue)

		XCTAssertEqual(c, d)
	}
}
