//
//  Canvas.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 3/24/19.
//  Copyright © 2019 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

class Canvas: CustomStringConvertible, Equatable {
	
	var description: String
	
	var width: Int = 0
	var height: Int = 0
	
	var pixelData: [[Color]]
	
	init(_ width: Int, _ height: Int) {
		description = "Canvas width: \(width), height: \(height)"
		
		self.width = width
		self.height = height
		
		let black = Color(0, 0, 0)
		
		pixelData = Array(repeating: Array(repeating: black, count: height), count: width)
		
		for y in 0..<width {
			for x in 0..<height {
				
				writePixel(y, x, black)
			}
		}
	}
	
	func writePixel(_ y: Int, _ x: Int, _ color: Color) {
		pixelData[y][x] = color
	}
	
	func pixelAt(_ y: Int, _ x: Int) -> Color {
		// TODO: assumes y and x are valid
		return pixelData[y][x]
	}
	
	func toPPM() {
		let file = PPMFileFormat(self)
		
	}
	
	static func == (lhs: Canvas, rhs: Canvas) -> Bool {
		return false
	}
}
