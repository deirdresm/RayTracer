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

	func lighting(light: Light, position: Point, eyeV: Vector, normalV: Vector, inShadow: Bool = false) -> VColor {
		var _diffuse = VColor.black
		var _specular = VColor.black

		// combine the surface color with the light's color/intensity
		let effectiveColor: VColor = self.color * light.color

		// compute the ambient contribution
		let _ambient: VColor = effectiveColor * self.ambient

		if (inShadow) {
			return _ambient
		}

		// find the direction to the light source from P
		let lightV = (light.position - position).normalize()

		// light_dot_normal represents the cosine of the angle between the
		// light vector and the normal vector. A negative number means the
		// light is on the other side of the surface.
		let lightDotNormal = lightV • normalV

		if lightDotNormal >= 0 {
			// compute the diffuse contribution
			_diffuse = effectiveColor * self.diffuse * lightDotNormal

			// ​reflect_dot_eye represents the cosine of the angle between the
			// reflection vector and the eye vector. A negative number means the
			// light reflects away from the eye.

			let reflectV = (-lightV).reflect(normalV)

			let reflectDotEye = reflectV • eyeV

			// reflection amoount the eye sees
			if reflectDotEye >= 0 {
				// compute the specular contribution
				let factor = pow(reflectDotEye, shininess)
				_specular = light.color * self.specular * factor
			} else {	// light reflects away from eye
				_specular = .black
			}
		}

		return _ambient + _diffuse + _specular
	}
}
