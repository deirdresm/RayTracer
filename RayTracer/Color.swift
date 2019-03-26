//
//  Color.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 3/5/19.
//  Copyright © 2019 Deirdre Saoirse Moen. All rights reserved.
//

import AppKit

class Color : Vector {
	
	public var red: CGFloat {
		get {
			return CGFloat(x)
		}
		set(newRed) {
			self.x = newRed
		}
	}
	
	public var green: CGFloat {
		get {
			return CGFloat(y)
		}
		set(newGreen) {
			self.y = newGreen
		}
	}
	
	public var blue: CGFloat {
		get {
			return CGFloat(z)
		}
		set(newBlue) {
			self.z = newBlue
		}
	}
	
	static public var black: NSColor = NSColor.black
	
	func nsColor() -> NSColor {
		return NSColor(red: x, green: y, blue: z, alpha: 1.0)
	}
	
	override var description: String {
		return("Point: x: \(x), y: \(y), z: \(z), w: \(w)")
	}
}

extension NSColor {
	func normalized(_ value: CGFloat) -> CGFloat {
		return value / 255.0
	}
}
