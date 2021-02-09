//
//  Vector.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 2/26/19.
//  Copyright © 2019 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name

class Vector : Tuple {
	
	init(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat) {
		super.init(x, y, z, 0.0)
	}

	override var description: String {
		return("Vector: x: \(x), y: \(y), z: \(z), w: \(w)")
	}
	
	override public func normalize() -> Vector {
		
		let magSquared = self.x*self.x + self.y*self.y + self.z*self.z + self.w*self.w
		let sq = 1.0/sqrt(magSquared)
		
		let normal = Vector(self.x*sq, self.y*sq, self.z*sq)
		
		return normal
	}

	static func + (lhs: Vector, rhs: Vector) -> Vector {
		let x = lhs.x + rhs.x
		let y = lhs.y + rhs.y
		let z = lhs.z + rhs.z
		
		return Vector(x, y, z)
	}
	
	static func + (lhs: Point, rhs: Vector) -> Vector {
		let x = lhs.x + rhs.x
		let y = lhs.y + rhs.y
		let z = lhs.z + rhs.z
		
		return Vector(x, y, z)
	}
	
    static func + (lhs: Vector, rhs: Point) -> Vector {
        let x = lhs.x + rhs.x
        let y = lhs.y + rhs.y
        let z = lhs.z + rhs.z

        return Vector(x, y, z)
    }

    static func += (lhs: Vector, rhs: Vector) -> some Vector {
        let x = lhs.x + rhs.x
        let y = lhs.y + rhs.y
        let z = lhs.z + rhs.z

        return Vector(x, y, z)
    }

    static func * (lhs: Vector, rhs: CGFloat) -> Vector {
		let x = lhs.x * rhs
		let y = lhs.y * rhs
		let z = lhs.z * rhs
		
		return Vector(x, y, z)
	}
	
	static func * (lhs: Vector, rhs: Vector) -> Vector {
		let x = lhs.x * rhs.x
		let y = lhs.y * rhs.y
		let z = lhs.z * rhs.z
		
		return Vector(x, y, z)
	}

}
