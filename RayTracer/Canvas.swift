//
//  Canvas.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 3/24/19.
//  Copyright © 2019 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name

class Canvas: CustomStringConvertible, Equatable {

	var description: String

	var width: Int = 0
	var height: Int = 0

	let maxColorValue = 255

	var pixelData: [[VColor]]

	init(_ width: Int, _ height: Int) {
		description = "Canvas width: \(width), height: \(height)"

		self.width = width
		self.height = height

		let black = VColor(0, 0, 0)

		pixelData = Array(repeating: Array(repeating: black, count: width), count: height)
	}

	func writePixel(_ x: Int, _ y: Int, _ color: VColor) {
        guard y < height else { return }
		pixelData[y][x] = color.clamped()
	}

	func pixel(at x: Int, _ y: Int) -> VColor {
		// TODO: assumes y and x are valid
		return pixelData[y][x]
	}

	func toPPM() -> String {
		let file = PPMFileFormat(self)

		return file.fileOutput
	}

	static func == (lhs: Canvas, rhs: Canvas) -> Bool { // TODO: make this work
		if lhs.width != rhs.width || lhs.height != rhs.height {
			return false
		}

		for y in 0..<lhs.height {
			for x in 0..<lhs.width {
				if lhs.pixel(at: x, y) != rhs.pixel(at: x, y) {
					return false
				}
			}
		}

		return true
	}
}
