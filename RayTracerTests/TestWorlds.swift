//
//  TestWorlds.swift
//  RayTracerTests
//
//  Created by Deirdre Saoirse Moen on 1/24/22.
//  Copyright © 2022 Deirdre Saoirse Moen. All rights reserved.
//

import XCTest
@testable import RayTracer

class TestWorlds: XCTestCase {

//	Feature: World
//
//	Scenario: Creating a world
//	  Given w ← world()
//	  Then w contains no objects
//		And w has no light source

	func testDefaultWorldEmpty() {
		let world = World()
		XCTAssertEqual(world.objects.count, 0)
		XCTAssertEqual(world.lights.count, 0)
	}

//	Scenario: The default world
//	  Given light ← point_light(point(-10, 10, -10), color(1, 1, 1))
//		And s1 ← sphere() with:
//		  | material.color     | (0.8, 1.0, 0.6)        |
//		  | material.diffuse   | 0.7                    |
//		  | material.specular  | 0.2                    |
//		And s2 ← sphere() with:
//		  | transform | scaling(0.5, 0.5, 0.5) |
//	  When w ← default_world()
//	  Then w.light = light
//		And w contains s1
//		And w contains s2

	func testDefaultWorldWithLightAndSpheres() {
		let world = World.defaultWorld()

		XCTAssertEqual(world.objects.count, 2)
		XCTAssertEqual(world.lights.count, 1)

		let light = Light(position: Point(-10, 10, -10), color: .white)

		let sphereOne = Sphere()
		let material = Material(diffuse: 0.7, specular: 0.2, color: VColor(0.8, 1.0, 0.6))
		sphereOne.material = material

		let sphereTwo = Sphere()
		sphereTwo.setTransform(Matrix.scaling(point: Point(0.5, 0.5, 0.5)))
		XCTAssertEqual(world.lights.first, light)

		// until I decide which way I want to go with equating spheres….
		let s1 = world.objects.first as? Sphere
		XCTAssertEqual(s1?.origin.x, sphereOne.origin.x)
		XCTAssertEqual(s1?.origin.y, sphereOne.origin.y)
		XCTAssertEqual(s1?.origin.z, sphereOne.origin.z)
		XCTAssertEqual(s1?.radius,   sphereOne.radius)
	}

//	Scenario: Intersect a world with a ray
//	  Given w ← default_world()
//		And r ← ray(point(0, 0, -5), vector(0, 0, 1))
//	  When xs ← intersect_world(w, r)
//	  Then xs.count = 4
//		And xs[0].t = 4
//		And xs[1].t = 4.5
//		And xs[2].t = 5.5
//		And xs[3].t = 6

	func testWorldIntersectionsWithRay() {
		let world = World.defaultWorld()

		var ray = Ray(origin: Point(0, 0, -5), direction: Vector(0, 0, 1))

		let sphereOne = Sphere()
		let material = Material(diffuse: 0.7, specular: 0.2, color: VColor(0.8, 1.0, 0.6))
		sphereOne.material = material

		let sphereTwo = Sphere()
		sphereTwo.setTransform(Matrix.scaling(point: Point(0.5, 0.5, 0.5)))

		world.objects = [sphereOne, sphereTwo]

		let xs = world.intersections(ray: &ray)

		XCTAssertEqual(xs.count, 4)

		XCTAssertEqual(xs[0].distance, 4)		// near outer
		XCTAssertEqual(xs[1].distance, 4.5)		// near inner
		XCTAssertEqual(xs[2].distance, 5.5)		// far inner
		XCTAssertEqual(xs[3].distance, 6)		// far outer
	}

//	Scenario: Shading an intersection
//	  Given w ← default_world()
//		And r ← ray(point(0, 0, -5), vector(0, 0, 1))
//		And shape ← the first object in w
//		And i ← intersection(4, shape)
//	  When comps ← prepare_computations(i, r)
//		And c ← shade_hit(w, comps)
//	  Then c = color(0.38066, 0.47583, 0.2855)

	func testShadingAnIntersection() {
		let w = World.defaultWorld()
		let ray = Ray(origin: Point(0, 0, -5), direction: Vector(0, 0, 1))
		let shape = w.objects.first!
		let intersection = Intersection(distance: 4, shape: shape)
		let comps = IntersectionState(intersection: intersection, ray: ray)
		let color = w.shadeHit(with: comps)

		XCTAssertEqual(color, VColor(0.38066, 0.47583, 0.2855))		// far outer
	}

//	Scenario: Shading an intersection from the inside
//	  Given w ← default_world()
//		And w.light ← point_light(point(0, 0.25, 0), color(1, 1, 1))
//		And r ← ray(point(0, 0, 0), vector(0, 0, 1))
//		And shape ← the second object in w
//		And i ← intersection(0.5, shape)
//	  When comps ← prepare_computations(i, r)
//		And c ← shade_hit(w, comps)
//	  Then c = color(0.90498, 0.90498, 0.90498)

	func testShadingAnIntersectionFromInside() {
		let world = World.defaultWorld()

		let light = Light(position: Point(0, 0.25, 0), color: .white)
		world.lights = [light]

		let ray = Ray(origin: Point(0, 0, 0), direction: Vector(0, 0, 1))
		let shape = world.objects[1] // second object

		let intersection = Intersection(distance: 0.5, shape: shape)

		let comps = IntersectionState(intersection: intersection, ray: ray)
		let color = world.shadeHit(with: comps)

		XCTAssertEqual(color, VColor(0.90498, 0.90498, 0.90498))
	}

//	Scenario: The color when a ray misses
//	  Given w ← default_world()
//		And r ← ray(point(0, 0, -5), vector(0, 1, 0))
//	  When c ← color_at(w, r)
//	  Then c = color(0, 0, 0)

	func testColorWhenRayMisses() {
		let world = World.defaultWorld()

		var ray = Ray(origin: Point(0, 0, -5), direction: Vector(0, 1, 0))
		let color = world.color(at: &ray)

		XCTAssertEqual(color, .black)
	}

//	Scenario: The color when a ray hits
//	  Given w ← default_world()
//		And r ← ray(point(0, 0, -5), vector(0, 0, 1))
//	  When c ← color_at(w, r)
//	  Then c = color(0.38066, 0.47583, 0.2855)

	func testColorWhenRayHits() {
		let world = World.defaultWorld()

		var ray = Ray(origin: Point(0, 0, -5), direction: Vector(0, 0, 1))
		let color = world.color(at: &ray)

		XCTAssertEqual(color, VColor(0.38066, 0.47583, 0.2855))
	}

//	Scenario: The color with an intersection behind the ray
//	  Given w ← default_world()
//		And outer ← the first object in w
//		And outer.material.ambient ← 1
//		And inner ← the second object in w
//		And inner.material.ambient ← 1
//		And r ← ray(point(0, 0, 0.75), vector(0, 0, -1))
//	  When c ← color_at(w, r)
//	  Then c = inner.material.color

	func testColorWhenIntersectionBehindRay() {
		let world = World.defaultWorld()

		var outer = world.objects.first!
		var inner = world.objects.last!

		outer.material.ambient = 1.0
		inner.material.ambient = 1.0

		var ray = Ray(origin: Point(0, 0, 0.75), direction: Vector(0, 0, -1))

		let color = world.color(at: &ray)

		XCTAssertEqual(color, inner.material.color)
	}

//	Scenario: There is no shadow when nothing is collinear with point and light
//	  Given w ← default_world()
//		And p ← point(0, 10, 0)
//	   Then is_shadowed(w, p) is false

	func testNoShadowsWhenNothingCollinear() {
		let world = World.defaultWorld()

		let point = Point(0, 10, 0)

		XCTAssertEqual(world.isShadowed(point: point), false)
	}

//	Scenario: The shadow when an object is between the point and the light
//	  Given w ← default_world()
//		And p ← point(10, -10, 10)
//	   Then is_shadowed(w, p) is true

	func testShadowsWhenObjectBetweenPointAndLight() {
		let world = World.defaultWorld()

		let point = Point(10, -10, 10)

		XCTAssertEqual(world.isShadowed(point: point), true)
	}

//	Scenario: There is no shadow when an object is behind the light
//	  Given w ← default_world()
//		And p ← point(-20, 20, -20)
//	   Then is_shadowed(w, p) is false

	func testNoShadowsWhenObjectBehindLight() {
		let world = World.defaultWorld()

		let point = Point(-20, 20, -20)

		XCTAssertEqual(world.isShadowed(point: point), false)
	}

//	Scenario: There is no shadow when an object is behind the point
//	  Given w ← default_world()
//		And p ← point(-2, 2, -2)
//	   Then is_shadowed(w, p) is false

	func testNoShadowsWhenObjectBehindPoint() {
		let world = World.defaultWorld()

		let point = Point(-2, 2, -2)

		XCTAssertEqual(world.isShadowed(point: point), false)
	}

//	Scenario: shade_hit() is given an intersection in shadow
//	  Given w ← world()
//		And w.light ← point_light(point(0, 0, -10), color(1, 1, 1))
//		And s1 ← sphere()
//		And s1 is added to w
//		And s2 ← sphere() with:
//		  | transform | translation(0, 0, 10) |
//		And s2 is added to w
//		And r ← ray(point(0, 0, 5), vector(0, 0, 1))
//		And i ← intersection(4, s2)
//	  When comps ← prepare_computations(i, r)
//		And c ← shade_hit(w, comps)
//	  Then c = color(0.1, 0.1, 0.1)

	func testShadeHitInShadow() {
		let world = World()
		let light = Light(position: Point(0, 0, -10), color: .white)
		world.lights = [light]

		let s1 = Sphere()
		let s2 = Sphere()
		let m = Matrix.identity
		s2.transform = m.translated(Point(0, 0, 10))
		world.objects = [s1, s2]

		let ray = Ray(origin: Point(0, 0, 5), direction: Vector(0, 0, 1))

		let intersection = Intersection(distance: 4, shape: s2)
		let comps = IntersectionState(intersection: intersection, ray: ray)
		let color = world.shadeHit(with: comps)

		XCTAssertEqual(color, VColor(0.1, 0.1, 0.1))
	}

//	Scenario: The reflected color for a nonreflective material
//	  Given w ← default_world()
//		And r ← ray(point(0, 0, 0), vector(0, 0, 1))
//		And shape ← the second object in w
//		And shape.material.ambient ← 1
//		And i ← intersection(1, shape)
//	  When comps ← prepare_computations(i, r)
//		And color ← reflected_color(w, comps)
//	  Then color = color(0, 0, 0)
//
//	Scenario: The reflected color for a reflective material
//	  Given w ← default_world()
//		And shape ← plane() with:
//		  | material.reflective | 0.5                   |
//		  | transform           | translation(0, -1, 0) |
//		And shape is added to w
//		And r ← ray(point(0, 0, -3), vector(0, -√2/2, √2/2))
//		And i ← intersection(√2, shape)
//	  When comps ← prepare_computations(i, r)
//		And color ← reflected_color(w, comps)
//	  Then color = color(0.19032, 0.2379, 0.14274)
//
//	Scenario: shade_hit() with a reflective material
//	  Given w ← default_world()
//		And shape ← plane() with:
//		  | material.reflective | 0.5                   |
//		  | transform           | translation(0, -1, 0) |
//		And shape is added to w
//		And r ← ray(point(0, 0, -3), vector(0, -√2/2, √2/2))
//		And i ← intersection(√2, shape)
//	  When comps ← prepare_computations(i, r)
//		And color ← shade_hit(w, comps)
//	  Then color = color(0.87677, 0.92436, 0.82918)
//
//	Scenario: color_at() with mutually reflective surfaces
//	  Given w ← world()
//		And w.light ← point_light(point(0, 0, 0), color(1, 1, 1))
//		And lower ← plane() with:
//		  | material.reflective | 1                     |
//		  | transform           | translation(0, -1, 0) |
//		And lower is added to w
//		And upper ← plane() with:
//		  | material.reflective | 1                    |
//		  | transform           | translation(0, 1, 0) |
//		And upper is added to w
//		And r ← ray(point(0, 0, 0), vector(0, 1, 0))
//	  Then color_at(w, r) should terminate successfully
//
//	Scenario: The reflected color at the maximum recursive depth
//	  Given w ← default_world()
//		And shape ← plane() with:
//		  | material.reflective | 0.5                   |
//		  | transform           | translation(0, -1, 0) |
//		And shape is added to w
//		And r ← ray(point(0, 0, -3), vector(0, -√2/2, √2/2))
//		And i ← intersection(√2, shape)
//	  When comps ← prepare_computations(i, r)
//		And color ← reflected_color(w, comps, 0)
//	  Then color = color(0, 0, 0)
//
//	Scenario: The refracted color with an opaque surface
//	  Given w ← default_world()
//		And shape ← the first object in w
//		And r ← ray(point(0, 0, -5), vector(0, 0, 1))
//		And xs ← intersections(4:shape, 6:shape)
//	  When comps ← prepare_computations(xs[0], r, xs)
//		And c ← refracted_color(w, comps, 5)
//	  Then c = color(0, 0, 0)
//
//	Scenario: The refracted color at the maximum recursive depth
//	  Given w ← default_world()
//		And shape ← the first object in w
//		And shape has:
//		  | material.transparency     | 1.0 |
//		  | material.refractive_index | 1.5 |
//		And r ← ray(point(0, 0, -5), vector(0, 0, 1))
//		And xs ← intersections(4:shape, 6:shape)
//	  When comps ← prepare_computations(xs[0], r, xs)
//		And c ← refracted_color(w, comps, 0)
//	  Then c = color(0, 0, 0)
//
//	Scenario: The refracted color under total internal reflection
//	  Given w ← default_world()
//		And shape ← the first object in w
//		And shape has:
//		  | material.transparency     | 1.0 |
//		  | material.refractive_index | 1.5 |
//		And r ← ray(point(0, 0, √2/2), vector(0, 1, 0))
//		And xs ← intersections(-√2/2:shape, √2/2:shape)
//	  # NOTE: this time you're inside the sphere, so you need
//	  # to look at the second intersection, xs[1], not xs[0]
//	  When comps ← prepare_computations(xs[1], r, xs)
//		And c ← refracted_color(w, comps, 5)
//	  Then c = color(0, 0, 0)
//
//	Scenario: The refracted color with a refracted ray
//	  Given w ← default_world()
//		And A ← the first object in w
//		And A has:
//		  | material.ambient | 1.0            |
//		  | material.pattern | test_pattern() |
//		And B ← the second object in w
//		And B has:
//		  | material.transparency     | 1.0 |
//		  | material.refractive_index | 1.5 |
//		And r ← ray(point(0, 0, 0.1), vector(0, 1, 0))
//		And xs ← intersections(-0.9899:A, -0.4899:B, 0.4899:B, 0.9899:A)
//	  When comps ← prepare_computations(xs[2], r, xs)
//		And c ← refracted_color(w, comps, 5)
//	  Then c = color(0, 0.99888, 0.04725)
//
//	Scenario: shade_hit() with a transparent material
//	  Given w ← default_world()
//		And floor ← plane() with:
//		  | transform                 | translation(0, -1, 0) |
//		  | material.transparency     | 0.5                   |
//		  | material.refractive_index | 1.5                   |
//		And floor is added to w
//		And ball ← sphere() with:
//		  | material.color     | (1, 0, 0)                  |
//		  | material.ambient   | 0.5                        |
//		  | transform          | translation(0, -3.5, -0.5) |
//		And ball is added to w
//		And r ← ray(point(0, 0, -3), vector(0, -√2/2, √2/2))
//		And xs ← intersections(√2:floor)
//	  When comps ← prepare_computations(xs[0], r, xs)
//		And color ← shade_hit(w, comps, 5)
//	  Then color = color(0.93642, 0.68642, 0.68642)
//
//	Scenario: shade_hit() with a reflective, transparent material
//	  Given w ← default_world()
//		And r ← ray(point(0, 0, -3), vector(0, -√2/2, √2/2))
//		And floor ← plane() with:
//		  | transform                 | translation(0, -1, 0) |
//		  | material.reflective       | 0.5                   |
//		  | material.transparency     | 0.5                   |
//		  | material.refractive_index | 1.5                   |
//		And floor is added to w
//		And ball ← sphere() with:
//		  | material.color     | (1, 0, 0)                  |
//		  | material.ambient   | 0.5                        |
//		  | transform          | translation(0, -3.5, -0.5) |
//		And ball is added to w
//		And xs ← intersections(√2:floor)
//	  When comps ← prepare_computations(xs[0], r, xs)
//		And color ← shade_hit(w, comps, 5)
//	  Then color = color(0.93391, 0.69643, 0.69243)

}
