//
//  Material.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 1/23/22.
//  Copyright © 2022 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

public struct Material: Equatable {

	// Note: no bounds checking; all should be non-negative.
	var ambient: CGFloat = 0.1
	var diffuse: CGFloat = 0.9
	var specular: CGFloat = 0.9
	var shininess: CGFloat = 200.0
	var reflectivity: CGFloat = 0.0
	var color: VColor = .white

	var description: String {
		return("Material: ambient: \(ambient), diffuse: \(diffuse), specular: \(specular), shininess: \(shininess)")
	}

	func lighting(light: Light, position: Point, eyeV: Vector, normalV: Vector) -> VColor {
		let specularColor: VColor

		// combine the surface color with the light's color/intensity
		let effectiveColor: VColor = color * light.intensity

		// find the direction to the light source
		let lightV = (light.position - position).normalize()

		// compute the ambient contribution
		let ambientColor: VColor = effectiveColor * ambient

		// light_dot_normal represents the cosine of the angle between the
		// light vector and the normal vector. A negative number means the
		// light is on the other side of the surface.
		let lightDotNormal = lightV • normalV

		guard lightDotNormal >= 0 else {
			return ambientColor
		}

		// compute the diffuse contriution
		let diffuseColor: VColor =  effectiveColor * (diffuse * lightDotNormal)

		// ​reflect_dot_eye represents the cosine of the angle between the
		// reflection vector and the eye vector. A negative number means the
		// light reflects away from the eye.

		let reflectV = (-lightV).reflect(normalV)
		let reflectDotEye = reflectV • eyeV

		if reflectDotEye < 0 {
			specularColor = .black
		} else {
			// compute the specular contribution
			let factor = pow(reflectDotEye, shininess)
			specularColor = light.intensity * specular * factor
		}

		return ambientColor + diffuseColor + specularColor
	}

}
