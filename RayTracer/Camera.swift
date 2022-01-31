//
//  Camera.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 1/27/22.
//  Copyright © 2022 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

struct Camera {
	let	width: 	Int
	let height: Int
	let fieldOfView: CGFloat
	let transform: Matrix
	let pixelSize: CGFloat

	private var halfWidth: CGFloat
	private var halfHeight: CGFloat

	init(width: Int, height: Int, fieldOfView: CGFloat, transform: Matrix = Matrix.identity) {
		self.width = width
		self.height = height
		self.fieldOfView = fieldOfView

		let halfView = tan(fieldOfView / 2)
		let aspect = CGFloat(width) / CGFloat(height)

		if aspect >= 1.0 {
			halfWidth = halfView
			halfHeight = halfView / aspect
		} else {
			halfWidth = halfView * aspect
			halfHeight = halfView
		}

		pixelSize = (halfWidth * 2) / CGFloat(width)
		self.transform = transform
	}

	func rayForPixel(x: Int, y: Int) -> Ray {
		// the offset from the edge of the canvas to the pixel's center
		let xoffset = (CGFloat(x) + 0.5) * pixelSize
		let yoffset = (CGFloat(y) + 0.5) * pixelSize

		// the untransformed coordinates of the pixel in world space.
		// (remember that the camera looks toward -z, so +x is to the *left*.)

		let worldX = halfWidth - xoffset
		let worldY = halfHeight - yoffset

		// using the camera matrix, transform the canvas point and the origin,
		// and then compute the ray's direction vector.
		// (remember that the canvas is at z=-1)

		let pixel = self.transform.inverse * Point(worldX, worldY, -1)
		let origin = self.transform.inverse * Point(0, 0, 0)
		let direction: Vector = (pixel - origin).normalize()

		return(Ray(origin: origin, direction: direction))
	}

	func render(world: World) -> Canvas {
		var image = Canvas(width, height)

		for y in 0 ..< height {
			for x in 0 ..< width {
				var ray = rayForPixel(x: x, y: y)
				let color = world.color(at: &ray)
				image.writePixel(x, y, color)
			}
		}

		return image
	}
}
