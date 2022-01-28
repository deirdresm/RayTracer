//
//  DrawWorld.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 1/28/22.
//  Copyright © 2022 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

struct DrawSphericalWorld {

	func makeSceneWithSpheres(width: Int) {
		var world = World()
		var floor = Sphere()
		floor.transform = Matrix.scaling(point: Point(10, 0.01, 10))
		var floorMaterial = Material()
		floorMaterial.color = VColor(0xde/255, 0xfb/255, 1)	// 0xdefbff
		floorMaterial.specular = 0
		floor.material = floorMaterial

		var leftWall = Sphere()
		leftWall.transform = Matrix.translation(Point(0, 0, 5)) *
							 Matrix.rotationY(radians: -CGFloat.pi / 4) *
							 Matrix.rotationX(radians: CGFloat.pi / 2) *
							 Matrix.scaling(point: Point(10, 0.01, 10))
		leftWall.material = floorMaterial

		var rightWall = Sphere()
		rightWall.transform = Matrix.translation(Point(0, 0, 5)) *
							  Matrix.rotationY(radians: CGFloat.pi / 4) *
							  Matrix.rotationX(radians: CGFloat.pi / 2) *
							  Matrix.scaling(point: Point(10, 0.01, 10))
		rightWall.material = floorMaterial

		var middleSphere = Sphere()
		middleSphere.transform = Matrix.translation(Point(-0.5, 1, 0.5))
		var msMaterial = Material()
		msMaterial.color = VColor(0x28/255, 0x6a/255, 0x8c/255) // 0x286a8c
		msMaterial.diffuse = 0.7
		msMaterial.specular = 0.3
		middleSphere.material = msMaterial

		var rightSphere = Sphere()
		rightSphere.transform = Matrix.translation(Point(1.5, 0.5, -0.5)) *
								Matrix.scaling(point: Point(0.5, 0.5, 0.5))
		var rsMaterial = Material()
		rsMaterial.color = VColor(0x12/255, 0x25/255, 0x21/255) // 0x122521
		rsMaterial.diffuse = 0.7
		rsMaterial.specular = 0.3
		rightSphere.material = rsMaterial

		var tinySphere = Sphere()
		tinySphere.transform = Matrix.translation(Point(-1.5, 0.33, -0.75)) *
								Matrix.scaling(point: Point(0.33, 0.33, 0.33))
		var tinyMaterial = Material()
		tinyMaterial.color = VColor(0, 0x26/255, 0x75/255) // 0x002675
		tinyMaterial.diffuse = 0.7
		tinyMaterial.specular = 0.3
		tinySphere.material = tinyMaterial

		let cameraTransform = Matrix.viewTransform(from: Point(0, 1.5, -5),
												to: Point(0, 1, 0),
												up: Vector(0, 1, 0))
		let camera = Camera(width: width, height: width / 2, fieldOfView: CGFloat.pi / 3, transform: cameraTransform)

		let lightPosition = Point(-10, 10, -10)
		let lightColor: VColor = .white
		let light = Light(position: lightPosition, color: lightColor)

		world.lights = [light]
		world.objects = [floor, leftWall, rightWall, middleSphere, rightSphere, tinySphere]

		let canvas = camera.render(world: world)

		FileManager.default.writeRenderedFile(canvas: canvas, fileName: "sceneWithSpheres.ppm")
	}
}
