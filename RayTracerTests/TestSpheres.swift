//
//  TestSpheres.swift
//  RayTracerTests
//
//  Created by Deirdre Saoirse Moen on 2/17/21.
//  Copyright © 2021 Deirdre Saoirse Moen. All rights reserved.
//

import XCTest
@testable import RayTracer

// swiftlint:disable identifier_name

class TestSpheres: XCTestCase {
	let epsilon: CGFloat = 0.00001

//    Scenario: A ray intersects a sphere at two points
//      Given r ← ray(point(0, 0, -5), vector(0, 0, 1))
//        And s ← sphere()
//      When xs ← intersect(s, r)
//      Then xs.count = 2
//        And xs[0] = 4.0
//        And xs[1] = 6.0

    func testRaySphereIntersections() {
        let ray = Ray(origin: Point(0, 0, -5), direction: Vector(0, 0, 1))
        let sphere = Sphere()
        let xs: [Intersection] = sphere.intersections(ray)
        XCTAssertEqual(xs.count, 2)
        XCTAssertEqual(xs[0].distance, 4.0)
        XCTAssertEqual(xs[1].distance, 6.0)
    }

//    Scenario: A ray intersects a sphere at a tangent
//      Given r ← ray(point(0, 1, -5), vector(0, 0, 1))
//        And s ← sphere()
//      When xs ← intersect(s, r)
//      Then xs.count = 2
//        And xs[0] = 5.0
//        And xs[1] = 5.0

    func testRaySphereTangentIntersections() {
        let ray = Ray(origin: Point(0, 1, -5), direction: Vector(0, 0, 1))
        let sphere = Sphere()
        let xs: [Intersection] = sphere.intersections(ray)
        XCTAssertEqual(xs.count, 2)
        XCTAssertEqual(xs[0].distance, 5.0)
        XCTAssertEqual(xs[1].distance, 5.0)
    }

//    Scenario: A ray misses a sphere
//      Given r ← ray(point(0, 2, -5), vector(0, 0, 1))
//        And s ← sphere()
//      When xs ← intersect(s, r)
//      Then xs.count = 0

    func testRaySphereMiss() {
        let ray = Ray(origin: Point(0, 2, -5), direction: Vector(0, 0, 1))
        let sphere = Sphere()
        let xs: [Intersection] = sphere.intersections(ray)
        XCTAssertEqual(xs.count, 0)
    }

//    Scenario: A ray originates inside a sphere
//      Given r ← ray(point(0, 0, 0), vector(0, 0, 1))
//        And s ← sphere()
//      When xs ← intersect(s, r)
//      Then xs.count = 2
//        And xs[0] = -1.0
//        And xs[1] = 1.0

    func testRayOriginatesInsideSphere() {
        let ray = Ray(origin: Point(0, 0, 0), direction: Vector(0, 0, 1))
        let sphere = Sphere()
        let xs: [Intersection] = sphere.intersections(ray)
        XCTAssertEqual(xs.count, 2)
        XCTAssertEqual(xs[0].distance, -1.0)
        XCTAssertEqual(xs[1].distance, 1.0)
    }

//    Scenario: A sphere is behind a ray
//      Given r ← ray(point(0, 0, 5), vector(0, 0, 1))
//        And s ← sphere()
//      When xs ← intersect(s, r)
//      Then xs.count = 2
//        And xs[0] = -6.0
//        And xs[1] = -4.0

    func testSphereBehindRay() {
        let ray = Ray(origin: Point(0, 0, 5), direction: Vector(0, 0, 1))
        let sphere = Sphere()
        let xs: [Intersection] = sphere.intersections(ray)
        XCTAssertEqual(xs.count, 2)
        XCTAssertEqual(xs[0].distance, -6.0)
        XCTAssertEqual(xs[1].distance, -4.0)
    }

//    Scenario: Intersect sets the object on the intersection
//      Given r ← ray(point(0, 0, -5), vector(0, 0, 1))
//        And s ← sphere()
//      When xs ← intersect(s, r)
//      Then xs.count = 2
//        And xs[0].object = s
//        And xs[1].object = s

    func testIntersectionsSetObject() {
        let ray = Ray(origin: Point(0, 0, -5), direction: Vector(0, 0, 1))
        let sphere = Sphere()
        let xs: [Intersection] = sphere.intersections(ray)
        XCTAssertEqual(xs.count, 2)
        XCTAssertEqual(xs[0].shape as? Sphere, sphere)
        XCTAssertEqual(xs[1].shape as? Sphere, sphere)
    }

//    Scenario: A sphere's default transformation
//      Given s ← sphere()
//      Then s.transform = identity_matrix

    func testSphereDefaultTransform() {
        let sphere = Sphere()
        XCTAssertEqual(sphere.transform, Matrix.identity)
    }

//    Scenario: Changing a sphere's transformation
//      Given s ← sphere()
//        And t ← translation(2, 3, 4)
//      When set_transform(s, t)
//      Then s.transform = t

    func testSphereChangeTransform() {
        let sphere = Sphere()
        let t = Matrix.translation(Point(2,3,4))
        sphere.setTransform(t)
        XCTAssertEqual(sphere.transform, t)
    }

//    Scenario: Intersecting a scaled sphere with a ray
//      Given r ← ray(point(0, 0, -5), vector(0, 0, 1))
//        And s ← sphere()
//      When set_transform(s, scaling(2, 2, 2))
//        And xs ← intersect(s, r)
//      Then xs.count = 2
//        And xs[0].t = 3
//        And xs[1].t = 7

    func testScaledSphereIntersectsRay() {
        let r = Ray(origin: Point(0, 0, -5), direction: Vector(0, 0, 1))
        let sphere = Sphere()
        sphere.setTransform(Matrix.scaling(point: Point(2, 2, 2)))
        let xs = sphere.intersections(r)
        XCTAssertEqual(xs.count, 2)
        XCTAssertEqual(xs[0].distance, 3)
        XCTAssertEqual(xs[1].distance, 7)
    }

//    Scenario: Intersecting a translated sphere with a ray
//      Given r ← ray(point(0, 0, -5), vector(0, 0, 1))
//        And s ← sphere()
//      When set_transform(s, translation(5, 0, 0))
//        And xs ← intersect(s, r)
//      Then xs.count = 0

    func testTranslatedSphereIntersectsRay() {
        let r = Ray(origin: Point(0, 0, -5), direction: Vector(0, 0, 1))
        let sphere = Sphere()
        sphere.setTransform(Matrix.translation(Point(5, 0, 0)))
        let xs = sphere.intersections(r)
        XCTAssertEqual(xs.count, 0)

        // TODO: add another test case with a non-zero intersection count
    }

/// MARK: - Chapter 6.
	///
//    Scenario: The normal on a sphere at a point on the x axis
//      Given s ← sphere()
//      When n ← normal_at(s, point(1, 0, 0))
//      Then n = vector(1, 0, 0)

	func testSphereNormalOnXAxis() {
		let s = Sphere()
		let n = s.normalAt(Point(1, 0, 0))
		XCTAssertEqual(n, Vector(1, 0, 0))
	}

//    Scenario: The normal on a sphere at a point on the y axis
//      Given s ← sphere()
//      When n ← normal_at(s, point(0, 1, 0))
//      Then n = vector(0, 1, 0)

	func testSphereNormalOnYAxis() {
		let s = Sphere()
		let n = s.normalAt(Point(0, 1, 0))
		XCTAssertEqual(n, Vector(0, 1, 0))
	}

//    Scenario: The normal on a sphere at a point on the z axis
//      Given s ← sphere()
//      When n ← normal_at(s, point(0, 0, 1))
//      Then n = vector(0, 0, 1)

	func testSphereNormalOnZAxis() {
		let s = Sphere()
		let n = s.normalAt(Point(0, 0, 1))
		XCTAssertEqual(n, Vector(0, 0, 1))
	}

//    Scenario: The normal on a sphere at a nonaxial point
//      Given s ← sphere()
//      When n ← normal_at(s, point(√3/3, √3/3, √3/3))
//      Then n = vector(√3/3, √3/3, √3/3)

	func testSphereNormalNonaxialPoint() {
		let s = Sphere()
		let n = s.normalAt(Point(sqrt(3)/3, sqrt(3)/3, sqrt(3)/3))
		XCTAssertEqual(n, Vector(sqrt(3)/3, sqrt(3)/3, sqrt(3)/3))
	}

//    Scenario: The normal is a normalized vector
//      Given s ← sphere()
//      When n ← normal_at(s, point(√3/3, √3/3, √3/3))
//      Then n = normalize(n)

	func testSphereNormalNormalizedVector() {
		let s = Sphere()
		let n = s.normalAt(Point(sqrt(3)/3, sqrt(3)/3, sqrt(3)/3))
		XCTAssertEqual(n, n.normalize())
	}

//    Scenario: Computing the normal on a translated sphere
//      Given s ← sphere()
//        And set_transform(s, translation(0, 1, 0))
//      When n ← normal_at(s, point(0, 1.70711, -0.70711))
//      Then n = vector(0, 0.70711, -0.70711)

	func testSphereNormalTranslated() {
		let s = Sphere()
		s.setTransform(Matrix.translation(Point(0, 1, 0)))

		let n = s.normalAt(Point(0, 1.70711, -0.70711))
		XCTAssertEqual(n, Vector(0, 0.70711, -0.70711))
	}

//    Scenario: Computing the normal on a transformed sphere
//      Given s ← sphere()
//        And m ← scaling(1, 0.5, 1) * rotation_z(π/5)
//        And set_transform(s, m)
//      When n ← normal_at(s, point(0, √2/2, -√2/2))
//      Then n = vector(0, 0.97014, -0.24254)

	func testSphereNormalTransformed() {
		let s = Sphere()
		let m = Matrix.scaling(point: Point(1, 0.5, 1)) * Matrix.rotationZ(radians: CGFloat.pi / 5)
		s.setTransform(m)

		let n = s.normalAt(Point(0, sqrt(2)/2, -sqrt(2)/2))
		XCTAssertEqual(n, Vector(0,  0.97014, -0.24254))
	}

	// Materials (Chapter 6)

//    Scenario: A sphere has a default material
//      Given s ← sphere()
//      When m ← s.material
//      Then m = material()

	func testSphereHasDefaultMaterial() {
		let s = Sphere()
		let m = s.material
		XCTAssertEqual(m, Material())
	}

//    Scenario: A sphere may be assigned a material
//      Given s ← sphere()
//        And m ← material()
//        And m.ambient ← 1
//      When s.material ← m
//      Then s.material = m

	func testSphereAssignMaterial() {
		let s = Sphere()
		var m = Material()
		m.ambient = 1.0

		s.material = m

		XCTAssertEqual(m, s.material)
		XCTAssertEqual(m.ambient, s.material.ambient)
	}

//    Scenario: A helper for producing a sphere with a glassy material
//      Given s ← glass_sphere()
//      Then s.transform = identity_matrix
//        And s.material.transparency = 1.0
//        And s.material.refractive_index = 1.5

}
