//
//  TestCameras.swift
//  RayTracerTests
//
//  Created by Deirdre Saoirse Moen on 1/27/22.
//  Copyright © 2022 Deirdre Saoirse Moen. All rights reserved.
//

import XCTest
@testable import RayTracer

class TestCameras: XCTestCase {
//	Scenario: Constructing a camera
//	  Given hsize ← 160
//		And vsize ← 120
//		And field_of_view ← π/2
//	  When c ← camera(hsize, vsize, field_of_view)
//	  Then c.hsize = 160
//		And c.vsize = 120
//		And c.field_of_view = π/2
//		And c.transform = identity_matrix

	func testConstructingCamera() {
		let hsize = 160
		let vsize = 120
		let fieldOfView = CGFloat.pi / 2

		let camera = Camera(width: hsize, height: vsize, fieldOfView: fieldOfView)

		XCTAssertEqual(camera.width, hsize)
		XCTAssertEqual(camera.height, vsize)
		XCTAssertEqual(camera.fieldOfView, fieldOfView)
		XCTAssertEqual(camera.transform, Matrix.identity)
	}

//	Scenario: The pixel size for a horizontal canvas
//	  Given c ← camera(200, 125, π/2)
//	  Then c.pixel_size = 0.01

	func testPixelSizeForHorizontalCanvas() {
		let camera = Camera(width: 200, height: 125, fieldOfView: CGFloat.pi / 2)

		XCTAssertEqual(camera.pixelSize, 0.01, accuracy: CGFloat.epsilon)
	}

//	Scenario: The pixel size for a vertical canvas
//	  Given c ← camera(125, 200, π/2)
//	  Then c.pixel_size = 0.01

	func testPixelSizeForVerticalCanvas() {
		let camera = Camera(width: 125, height: 200, fieldOfView: CGFloat.pi / 2)

		XCTAssertEqual(camera.pixelSize, 0.01, accuracy: CGFloat.epsilon)
	}

//	Scenario: Constructing a ray through the center of the canvas
//	  Given c ← camera(201, 101, π/2)
//	  When r ← ray_for_pixel(c, 100, 50)
//	  Then r.origin = point(0, 0, 0)
//		And r.direction = vector(0, 0, -1)

	func testRayThroughCenterOfCanvas() {
		let camera = Camera(width: 201, height: 101, fieldOfView: CGFloat.pi / 2)
		let ray = camera.rayForPixel(x: 100, y: 50)

		XCTAssertEqual(ray.origin, Point(0, 0, 0))
		XCTAssertEqual(ray.direction, Vector(0, 0, -1))
	}

//	Scenario: Constructing a ray through a corner of the canvas
//	  Given c ← camera(201, 101, π/2)
//	  When r ← ray_for_pixel(c, 0, 0)
//	  Then r.origin = point(0, 0, 0)
//		And r.direction = vector(0.66519, 0.33259, -0.66851)

	func testRayThroughCornerOfCanvas() {
		let camera = Camera(width: 201, height: 101, fieldOfView: CGFloat.pi / 2)
		let ray = camera.rayForPixel(x: 0, y: 0)

		XCTAssertEqual(ray.origin, Point(0, 0, 0))
		XCTAssertEqual(ray.direction, Vector(0.66519, 0.33259, -0.66851))
	}

//	Scenario: Constructing a ray when the camera is transformed
//	  Given c ← camera(201, 101, π/2)
//	  When c.transform ← rotation_y(π/4) * translation(0, -2, 5)
//		And r ← ray_for_pixel(c, 100, 50)
//	  Then r.origin = point(0, 2, -5)
//		And r.direction = vector(√2/2, 0, -√2/2)

	func testRayWithTransformedCamera() {
		let transform = Matrix.rotationY(radians: CGFloat.pi / 4.0) * Matrix.translation(Point(0, -2, 5))
		var camera = Camera(width: 201, height: 101, fieldOfView: CGFloat.pi / 2, transform: transform)
		let ray = camera.rayForPixel(x: 100, y: 50)

		XCTAssertEqual(ray.origin, Point(0, 2, -5))
		XCTAssertEqual(ray.direction, Vector(sqrt(2)/2, 0, -sqrt(2)/2))
	}

//	Scenario: Rendering a world with a camera
//	  Given w ← default_world()
//		And c ← camera(11, 11, π/2)
//		And from ← point(0, 0, -5)
//		And to ← point(0, 0, 0)
//		And up ← vector(0, 1, 0)
//		And c.transform ← view_transform(from, to, up)
//	  When image ← render(c, w)
//	  Then pixel_at(image, 5, 5) = color(0.38066, 0.47583, 0.2855)

	func testRenderWithCamera() {
		let world = World.defaultWorld()
		let from = Point(0, 0, -5)
		let to = Point(0, 0, 0)
		let up = Vector(0, 1, 0)
		let transform = Matrix.viewTransform(from: from, to: to, up: up)
		var camera = Camera(width: 11, height: 11, fieldOfView: CGFloat.pi / 2, transform: transform)
		let image = camera.render(world: world)

		XCTAssertEqual(image.pixel(at: 5, 5), VColor(0.38066, 0.47583, 0.2855))
	}
}
