//
//  TestIntersections.swift
//  RayTracerTests
//
//  Created by Deirdre Saoirse Moen on 3/6/21.
//  Copyright © 2021 Deirdre Saoirse Moen. All rights reserved.
//

import XCTest
@testable import RayTracer

class TestIntersections: XCTestCase {

//    Scenario: An intersection encapsulates t and object
//      Given s ← sphere()
//      When i ← intersection(3.5, s)
//      Then i.t = 3.5
//        And i.object = s

    func testIntersectionAttributes() {
        let s = Sphere()
        let i = Intersection(distance: 3.5, shape: s)
        XCTAssertEqual(i.distance, 3.5)
        XCTAssertEqual(i.shape as? Sphere, s)
    }

//    Scenario: Precomputing the state of an intersection
//      Given r ← ray(point(0, 0, -5), vector(0, 0, 1))
//        And shape ← sphere()
//        And i ← intersection(4, shape)
//      When comps ← prepare_computations(i, r)
//      Then comps.t = i.t
//        And comps.object = i.object
//        And comps.point = point(0, 0, -1)
//        And comps.eyev = vector(0, 0, -1)
//        And comps.normalv = vector(0, 0, -1)

	func testPrecomputeIntersectionState() {
		let ray = Ray(origin: Point(0, 0, -5), direction: Vector(0, 0, 1))
		let sphere = Sphere()

		let i = Intersection(distance: 4, shape: sphere)

		// shout out to @ateliercw for the better name
		let comps = IntersectionState(intersection: i, ray: ray)
		
		XCTAssertEqual(comps.distance, i.distance)
		XCTAssertEqual(comps.shape.id, i.shape.id)
		XCTAssertEqual(comps.point, Point(0, 0, -1))
		XCTAssertEqual(comps.eyeV, Vector(0, 0, -1))
		XCTAssertEqual(comps.normalV, Vector(0, 0, -1))
	}

//    Scenario: Precomputing the reflection vector
//      Given shape ← plane()
//        And r ← ray(point(0, 1, -1), vector(0, -√2/2, √2/2))
//        And i ← intersection(√2, shape)
//      When comps ← prepare_computations(i, r)
//      Then comps.reflectv = vector(0, √2/2, √2/2)

//	func testPrecomputeReflectionVector() {
//		let ray = Ray(origin: Point(0, 1, -1), direction: Vector(0, -sqrt(2)/2, sqrt(2)/2))
//		let sphere = Sphere()
//
//		let i = Intersection(distance: sqrt(2), shape: sphere)
//
//		// shout out to @ateliercw for the better name
//		let comps = IntersectionState(intersection: i, ray: ray)
//
//		XCTAssertEqual(comps.reflect, Vector(0, sqrt(2)/2, sqrt(2)/2))
//	}

//    Scenario: The hit, when an intersection occurs on the outside
//      Given r ← ray(point(0, 0, -5), vector(0, 0, 1))
//        And shape ← sphere()
//        And i ← intersection(4, shape)
//      When comps ← prepare_computations(i, r)
//      Then comps.inside = false

	func testHitOnOutside() {
		let ray = Ray(origin: Point(0, 0, -5), direction: Vector(0, 0, 1))
		let shape = Sphere()
		let intersection = Intersection(distance: 4, shape: shape)
		let comps = IntersectionState(intersection: intersection, ray: ray)

		XCTAssertEqual(comps.isInside, false)
	}

//    Scenario: The hit, when an intersection occurs on the inside
//      Given r ← ray(point(0, 0, 0), vector(0, 0, 1))
//        And shape ← sphere()
//        And i ← intersection(1, shape)
//      When comps ← prepare_computations(i, r)
//      Then comps.point = point(0, 0, 1)
//        And comps.eyev = vector(0, 0, -1)
//        And comps.inside = true
//          # normal would have been (0, 0, 1), but is inverted!
//        And comps.normalv = vector(0, 0, -1)

	func testHitOnInside() {
		let ray = Ray(origin: Point(0, 0, 0), direction: Vector(0, 0, 1))
		let shape = Sphere()
		let intersection = Intersection(distance: 1, shape: shape)
		let comps = IntersectionState(intersection: intersection, ray: ray)
		XCTAssertEqual(comps.point, Point(0, 0, 1))
		XCTAssertEqual(comps.eyeV, Vector(0, 0, -1))
		XCTAssertEqual(comps.isInside, true)

		// inverted because inside
		XCTAssertEqual(comps.normalV, Vector(0, 0, -1))
	}

//    Scenario: The hit should offset the point
//      Given r ← ray(point(0, 0, -5), vector(0, 0, 1))
//        And shape ← sphere() with:
//          | transform | translation(0, 0, 1) |
//        And i ← intersection(5, shape)
//      When comps ← prepare_computations(i, r)
//      Then comps.over_point.z < -EPSILON/2
//        And comps.point.z > comps.over_point.z

	func testHitShouldOffsetPoint() {
		let ray = Ray(origin: Point(0, 0, -5), direction: Vector(0, 0, 1))
		let shape = Sphere()
		let m = Matrix.identity
		shape.transform = m.translated(Point(0, 0, 1))

		let intersection = Intersection(distance: 5, shape: shape)
		let comps = IntersectionState(intersection: intersection, ray: ray)

		XCTAssertLessThan(comps.overPoint.z, -CGFloat.epsilon / 2)
		XCTAssertGreaterThan(comps.point.z, comps.overPoint.z)
	}

//    Scenario: The under point is offset below the surface
//      Given r ← ray(point(0, 0, -5), vector(0, 0, 1))
//        And shape ← glass_sphere() with:
//          | transform | translation(0, 0, 1) |
//        And i ← intersection(5, shape)
//        And xs ← intersections(i)
//      When comps ← prepare_computations(i, r, xs)
//      Then comps.under_point.z > EPSILON/2
//        And comps.point.z < comps.under_point.z
//
//    Scenario: Aggregating intersections
//      Given s ← sphere()
//        And i1 ← intersection(1, s)
//        And i2 ← intersection(2, s)
//      When xs ← intersections(i1, i2)
//      Then xs.count = 2
//        And xs[0].t = 1
//        And xs[1].t = 2

    func testAggregatingIntersections() {

        // note: this ray does not intersect this sphere
        // TODO: find a real ray value for this and other tests

        let origin = Point(1, 2, 3)
        let direction = Vector(4, 5, 6)
        var r = Ray(origin: origin, direction: direction)
        let s = Sphere()
        let i1 = Intersection(distance: 1, shape: s)
        let i2 = Intersection(distance: 2, shape: s)

        r.intersections = [i1, i2]
        XCTAssertEqual(r.intersections.count, 2)
        XCTAssertEqual(r.intersections[0].distance, 1)
        XCTAssertEqual(r.intersections[1].distance, 2)
    }

//    Scenario: The hit, when all intersections have positive t
//      Given s ← sphere()
//        And i1 ← intersection(1, s)
//        And i2 ← intersection(2, s)
//        And xs ← intersections(i2, i1)
//      When i ← hit(xs)
//      Then i = i1

    func testPositiveTHits() {

        // note: this ray does not intersect this sphere
        // TODO: find a real ray value for this and other tests

        let origin = Point(1, 2, 3)
        let direction = Vector(4, 5, 6)
        var r = Ray(origin: origin, direction: direction)
        let s = Sphere()
        let i1 = Intersection(distance: 1, shape: s)
        let i2 = Intersection(distance: 2, shape: s)

        r.intersections = [i1, i2]
        XCTAssertEqual(r.hit(), i1)
    }

//    Scenario: The hit, when some intersections have negative t
//      Given s ← sphere()
//        And i1 ← intersection(-1, s)
//        And i2 ← intersection(1, s)
//        And xs ← intersections(i2, i1)
//      When i ← hit(xs)
//      Then i = i2

    func testSomeNegativeTHits() {

        // note: this ray does not intersect this sphere
        // TODO: find a real ray value for this and other tests

        let origin = Point(1, 2, 3)
        let direction = Vector(4, 5, 6)
        var r = Ray(origin: origin, direction: direction)
        let s = Sphere()
        let i1 = Intersection(distance: -1, shape: s)
        let i2 = Intersection(distance: 1, shape: s)

        r.intersections = [i1, i2]
        XCTAssertEqual(r.hit(), i2)
    }

//    Scenario: The hit, when all intersections have negative t
//      Given s ← sphere()
//        And i1 ← intersection(-2, s)
//        And i2 ← intersection(-1, s)
//        And xs ← intersections(i2, i1)
//      When i ← hit(xs)
//      Then i is nothing

    func testAllNegativeIntersections() {

        // note: this ray does not intersect this sphere
        // TODO: find a real ray value for this and other tests

        let origin = Point(1, 2, 3)
        let direction = Vector(4, 5, 6)
        var r = Ray(origin: origin, direction: direction)
        let s = Sphere()
        let i1 = Intersection(distance: -2, shape: s)
        let i2 = Intersection(distance: -1, shape: s)

        r.intersections = [i1, i2]
        XCTAssertNil(r.hit())
    }

//    Scenario: The hit is always the lowest nonnegative intersection
//      Given s ← sphere()
//      And i1 ← intersection(5, s)
//      And i2 ← intersection(7, s)
//      And i3 ← intersection(-3, s)
//      And i4 ← intersection(2, s)
//      And xs ← intersections(i1, i2, i3, i4)
//    When i ← hit(xs)
//    Then i = i4

    func testLowestNonegativeHits() {

        // note: this ray does not intersect this sphere
        // TODO: find a real ray value for this and other tests

        let origin = Point(1, 2, 3)
        let direction = Vector(4, 5, 6)
        var r = Ray(origin: origin, direction: direction)
        let s = Sphere()
        let i1 = Intersection(distance: 5, shape: s)
        let i2 = Intersection(distance: 7, shape: s)
        let i3 = Intersection(distance: -3, shape: s)
        let i4 = Intersection(distance: 2, shape: s)

        r.intersections = [i1, i2, i3, i4]
        XCTAssertEqual(r.hit(), i4)
    }

//    Scenario Outline: Finding n1 and n2 at various intersections
//      Given A ← glass_sphere() with:
//          | transform                 | scaling(2, 2, 2) |
//          | material.refractive_index | 1.5              |
//        And B ← glass_sphere() with:
//          | transform                 | translation(0, 0, -0.25) |
//          | material.refractive_index | 2.0                      |
//        And C ← glass_sphere() with:
//          | transform                 | translation(0, 0, 0.25) |
//          | material.refractive_index | 2.5                     |
//        And r ← ray(point(0, 0, -4), vector(0, 0, 1))
//        And xs ← intersections(2:A, 2.75:B, 3.25:C, 4.75:B, 5.25:C, 6:A)
//      When comps ← prepare_computations(xs[<index>], r, xs)
//      Then comps.n1 = <n1>
//        And comps.n2 = <n2>
//
//      Examples:
//        | index | n1  | n2  |
//        | 0     | 1.0 | 1.5 |
//        | 1     | 1.5 | 2.0 |
//        | 2     | 2.0 | 2.5 |
//        | 3     | 2.5 | 2.5 |
//        | 4     | 2.5 | 1.5 |
//        | 5     | 1.5 | 1.0 |
//
//    Scenario: The Schlick approximation under total internal reflection
//      Given shape ← glass_sphere()
//        And r ← ray(point(0, 0, √2/2), vector(0, 1, 0))
//        And xs ← intersections(-√2/2:shape, √2/2:shape)
//      When comps ← prepare_computations(xs[1], r, xs)
//        And reflectance ← schlick(comps)
//      Then reflectance = 1.0
//
//    Scenario: The Schlick approximation with a perpendicular viewing angle
//      Given shape ← glass_sphere()
//        And r ← ray(point(0, 0, 0), vector(0, 1, 0))
//        And xs ← intersections(-1:shape, 1:shape)
//      When comps ← prepare_computations(xs[1], r, xs)
//        And reflectance ← schlick(comps)
//      Then reflectance = 0.04
//
//    Scenario: The Schlick approximation with small angle and n2 > n1
//      Given shape ← glass_sphere()
//        And r ← ray(point(0, 0.99, -2), vector(0, 0, 1))
//        And xs ← intersections(1.8589:shape)
//      When comps ← prepare_computations(xs[0], r, xs)
//        And reflectance ← schlick(comps)
//      Then reflectance = 0.48873
//
//    Scenario: An intersection can encapsulate `u` and `v`
//      Given s ← triangle(point(0, 1, 0), point(-1, 0, 0), point(1, 0, 0))
//      When i ← intersection_with_uv(3.5, s, 0.2, 0.4)
//      Then i.u = 0.2
//        And i.v = 0.4

}
