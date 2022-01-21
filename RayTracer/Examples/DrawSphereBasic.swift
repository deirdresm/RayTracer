//
//  DrawSphereBasic.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 1/21/22.
//  Copyright © 2022 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

struct DrawSphereBasic {

	// TODO: incomplete
	func makeSphericalSilhouette(width: Int) {
		let rayOrigin = Point(0, 0, -5)
		let wallZ = 10.0
		let wallSize = 8.0
		let pixelSize = wallSize / CGFloat(width)
		let halfWallSize = wallSize / 2

		let color = VColor(1, 0, 1)	// purple-ish
		let sphere = Sphere()

		var c = Canvas(width, width)

		for y in 0 ..< width {
			let worldY = halfWallSize - pixelSize * CGFloat(y)

			for x in 0 ..< width {
				let worldX = -halfWallSize + pixelSize * CGFloat(x)
				let position = Point(CGFloat(worldX), CGFloat(worldY), CGFloat(wallZ))

				let direction = position - rayOrigin

				let r = Ray(origin: rayOrigin,
							direction: direction.normalize())

				let xs = sphere.intersections(r)	// [Intersection] array returned

				if xs.count > 0 {	// there is at least one hit intersection
					c.writePixel(x, y, color)
				}

			}
		}

		FileManager.default.writeRenderedFile(canvas: c, fileName: "sphericalSilhouette.ppm")
	}

}
