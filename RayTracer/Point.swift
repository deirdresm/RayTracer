//
//  Point.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 2/26/19.
//  Copyright © 2019 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

class Point : Tuple {
	
	init(_ x: Double, _ y: Double, _ z: Double) {
		super.init(x, y, z, 1.0)
	}
	
	
	override var description: String {
		return("Point: x: \(x), y: \(y), z: \(z), w: \(w)")
	}
}
