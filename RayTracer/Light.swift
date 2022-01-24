//
//  Light.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 1/22/22.
//  Copyright © 2022 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation
struct Light {

	var position: Point
	var intensity: VColor

	var description: String {
		return("Light: position x: \(position.x), y: \(position.y), z: \(position.z), intensity x: \(intensity.x), y: \(intensity.y), z: \(intensity.z)")
	}
}
