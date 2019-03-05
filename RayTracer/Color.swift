//
//  Color.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 3/5/19.
//  Copyright © 2019 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

class Color : Vector {
	
	public var red: CGFloat {
		return CGFloat(self.x)
	}
	
	public var green: CGFloat {
		return CGFloat(self.y)
	}
	
	public var blue: CGFloat {
		return CGFloat(self.z)
	}

	convenience init(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat) {
		self.init(Double(x), Double(y), Double(z))
	}
	

	override var description: String {
		return("Point: x: \(x), y: \(y), z: \(z), w: \(w)")
	}
}
