//
//  Light.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 1/22/22.
//  Copyright © 2022 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation
struct Light: Equatable {

	var position: Point
	var color: VColor

	var description: String {
		return("Light: position x: \(position.x), y: \(position.y), z: \(position.z), color x: \(color.x), y: \(color.y), z: \(color.z)")
	}
}
