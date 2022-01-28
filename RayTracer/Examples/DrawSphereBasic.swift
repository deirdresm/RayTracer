//
//  DrawSphereBasic.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 1/21/22.
//  Copyright © 2022 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name

struct DrawSphere {

	// TODO: incomplete
	func makeSphericalSilhouette(width: Int) {
		let rayOrigin = Point(0, 0, -5)
		let wallZ = 10.0
		let wallSize = 8.0
		let pixelSize = wallSize / CGFloat(width)
		let halfWallSize = wallSize / 2

//		let color = VColor(1, 0, 1)	// purple-ish
		var sphere = Sphere()
		sphere.material = Material(color: VColor(1, 0.2, 1))

		let lightPosition = Point(-10, 10, -10)
		let lightColor: VColor = .white
		let light = Light(position: lightPosition, color: lightColor)

		var c = Canvas(width, width)

		for y in 0 ..< width {
			let worldY = halfWallSize - pixelSize * CGFloat(y)

			for x in 0 ..< width {
				let worldX = -halfWallSize + pixelSize * CGFloat(x)
				let position = Point(CGFloat(worldX), CGFloat(worldY), CGFloat(wallZ))

				let ray = Ray(origin: rayOrigin,
							  direction: (position - rayOrigin).normalize())
				let xs = sphere.intersections(ray)	// [Intersection] array returned

				if xs.count == 0 {
					continue
				}

				let hit = xs.sorted().first!

				let point = ray.position(hit.distance)
				let normal = (hit.shape).normal(at: point)
				let eyeV = -ray.direction as Vector

				let color = hit.shape.material.lighting(light: light,
												     position: point,
														 eyeV: eyeV,
													  normalV: normal)

				if xs.count > 0 {	// there is at least one hit intersection
					c.writePixel(x, y, color)
				}
			}
		}

		FileManager.default.writeRenderedFile(canvas: c, fileName: "sphericalSilhouette.ppm")
	}
}
