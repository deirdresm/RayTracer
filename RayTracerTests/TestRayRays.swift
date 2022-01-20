//
//  TestRayRays.swift
//  RayTracerTests
//
//  Created by Deirdre Saoirse Moen on 2/16/21.
//  Copyright © 2021 Deirdre Saoirse Moen. All rights reserved.
//

import XCTest
@testable import RayTracer

// swiftlint:disable identifier_name

// TODO: Missing test cases
// 1. other paths in hit function

class TestRayRay: XCTestCase {

//    Scenario: Creating and querying a ray
//      Given origin ← point(1, 2, 3)
//        And direction ← vector(4, 5, 6)
//      When r ← ray(origin, direction)
//      Then r.origin = origin
//        And r.direction = direction

    func testRayInitialization() {
        let origin = Point(1, 2, 3)
        let direction = Vector(4, 5, 6)
        let r = Ray(origin: origin, direction: direction)
        XCTAssertEqual(origin, r.origin)
        XCTAssertEqual(direction, r.direction)
    }

//    Scenario: Computing a point from a distance
//      Given r ← ray(point(2, 3, 4), vector(1, 0, 0))
//      Then position(r, 0) = point(2, 3, 4)
//        And position(r, 1) = point(3, 3, 4)
//        And position(r, -1) = point(1, 3, 4)
//        And position(r, 2.5) = point(4.5, 3, 4)

    func testDistanceComputation() {
        let r = Ray(origin: Point(2, 3, 4), direction: Vector(1, 0, 0))
        XCTAssertEqual(r.position(0), Point(2, 3, 4))
        XCTAssertEqual(r.position(1), Point(3, 3, 4))
        XCTAssertEqual(r.position(-1), Point(1, 3, 4))
        XCTAssertEqual(r.position(2.5), Point(4.5, 3, 4))
    }

//    Scenario: Translating a ray
//      Given r ← ray(point(1, 2, 3), vector(0, 1, 0))
//        And m ← translation(3, 4, 5)
//      When r2 ← transform(r, m)
//      Then r2.origin = point(4, 6, 8)
//        And r2.direction = vector(0, 1, 0)

    func testRayTranslation() {
        let r = Ray(origin: Point(1, 2, 3), direction: Vector(0, 1, 0))
        let m = Matrix.translation(Point(3, 4, 5))
        let r2 = r.transform(m)
        XCTAssertEqual(r2.origin, Point(4, 6, 8))
        XCTAssertEqual(r2.direction, Vector(0, 1, 0))
    }

//    Scenario: Scaling a ray
//      Given r ← ray(point(1, 2, 3), vector(0, 1, 0))
//        And m ← scaling(2, 3, 4)
//      When r2 ← transform(r, m)
//      Then r2.origin = point(2, 6, 12)
//        And r2.direction = vector(0, 3, 0)

    func testRayScaling() {
        let r = Ray(origin: Point(1, 2, 3), direction: Vector(0, 1, 0))
        let m = Matrix.scaling(point: Point(2, 3, 4))
        let r2 = r.transform(m)
        XCTAssertEqual(r2.origin, Point(2, 6, 12))
        XCTAssertEqual(r2.direction, Vector(0, 3, 0))
    }
}
