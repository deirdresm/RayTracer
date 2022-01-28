//
//  TestMatrixTransformations.swift
//  RayTracerTests
//
//  Created by Deirdre Saoirse Moen on 2/7/21.
//  Copyright © 2021 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation
import XCTest

@testable import RayTracer

// swiftlint:disable identifier_name

// TODO: Missing tests
// 1. translated

// MARK: test to pass accuracy comparison down from matrix to the individual values

class TestMatrixTransformations: XCTestCase {

//Scenario: Multiplying by a translation matrix
//  Given transform ← translation(5, -3, 2)
//    And p ← point(-3, 4, 5)
//   Then transform * p = point(2, 1, 7)

    func testPointTransform() {
        let t = Point(5, -3, 2)
        let transform = Matrix.translation(t) // result is a matrix

        let p = Point(-3, 4, 5)
        XCTAssertEqual(transform * p, Point(2, 1, 7))
    }

//Scenario: Multiplying by the inverse of a translation matrix
//  Given transform ← translation(5, -3, 2)
//    And inv ← inverse(transform)
//    And p ← point(-3, 4, 5)
//   Then inv * p = point(-8, 7, 3)

    func testPointInverseTranslation() {
        let t = Point(5, -3, 2)
        let transform = Matrix.translation(t)
        let inv = transform.inverse

        let p = Point(-3, 4, 5)
        XCTAssertEqual(inv * p, Point(-8, 7, 3))
    }

//Scenario: Translation does not affect vectors
//  Given transform ← translation(5, -3, 2)
//    And v ← vector(-3, 4, 5)
//   Then transform * v = v

    func testVectorTranslation() {
        let t = Point(5, -3, 2)
        let transform = Matrix.translation(t)

        let v = Vector(-3, 4, 5)
        XCTAssertEqual(transform * v, v)
    }

//Scenario: A scaling matrix applied to a point
//  Given transform ← scaling(2, 3, 4)
//    And p ← point(-4, 6, 8)
//   Then transform * p = point(-8, 18, 32)

    func testPointScaling() {
        let s = Point(2, 3, 4)
        let p = Point(-4, 6, 8)
        let scaled = Matrix.scaling(point: s)

        let v = Point(-8, 18, 32)
        XCTAssertEqual(scaled * p, v)
    }

//Scenario: A scaling matrix applied to a vector
//  Given transform ← scaling(2, 3, 4)
//    And v ← vector(-4, 6, 8)
//   Then transform * v = vector(-8, 18, 32)

    func testVectorScaling() {
        let s = Point(2, 3, 4)
        let p = Vector(-4, 6, 8)
        let scaled = Matrix.scaling(point: s)

        let v = Vector(-8, 18, 32)
        XCTAssertEqual(scaled * p, v)
    }

//Scenario: Multiplying by the inverse of a scaling matrix
//  Given transform ← scaling(2, 3, 4)
//    And inv ← inverse(transform)
//    And v ← vector(-4, 6, 8)
//   Then inv * v = vector(-2, 2, 2)

    func testInverseScaling() {
        let s = Point(2, 3, 4)
        let v = Vector(-4, 6, 8)
        let scaled = Matrix.scaling(point: s)
        let inv = scaled.inverse

        let v2 = Vector(-2, 2, 2)
        XCTAssertEqual(inv * v, v2)
    }

//Scenario: Reflection is scaling by a negative value
//  Given transform ← scaling(-1, 1, 1)
//    And p ← point(2, 3, 4)
//   Then transform * p = point(-2, 3, 4)

    func testReflectionScaling() {
        let s = Point(-1, 1, 1)
        let p = Point(2, 3, 4)
        let scaled = Matrix.scaling(point: s)

        let p2 = Point(-2, 3, 4)
        XCTAssertEqual(scaled * p, p2)
    }

//Scenario: Rotating a point around the x axis
//  Given p ← point(0, 1, 0)
//    And half_quarter ← rotation_x(π / 4)
//    And full_quarter ← rotation_x(π / 2)
//  Then half_quarter * p = point(0, √2/2, √2/2)
//    And full_quarter * p = point(0, 0, 1)

    func testRotationX() {
        let p = Point(0, 1, 0)
        let halfQuarter = Matrix.rotationX(radians: CGFloat.pi / 4)
        let fullQuarter = Matrix.rotationX(radians: CGFloat.pi / 2)

        XCTAssertEqual(halfQuarter * p, Point(0, sqrt(2)/2, sqrt(2)/2))
        XCTAssertEqual(fullQuarter * p, Point(0, 0, 1))
    }

//Scenario: The inverse of an x-rotation rotates in the opposite direction
//  Given p ← point(0, 1, 0)
//    And half_quarter ← rotation_x(π / 4)
//    And inv ← inverse(half_quarter)
//  Then inv * p = point(0, √2/2, -√2/2)

    func testInverseRotationX() {
        let p = Point(0, 1, 0)
        let halfQuarter = Matrix.rotationX(radians: CGFloat.pi / 4)
        let inv = halfQuarter.inverse
        let fullQuarter = Matrix.rotationX(radians: CGFloat.pi / 2)

        XCTAssertEqual(inv * p, Point(0, sqrt(2)/2, -sqrt(2)/2))
    }

//Scenario: Rotating a point around the y axis
//  Given p ← point(0, 0, 1)
//    And half_quarter ← rotation_y(π / 4)
//    And full_quarter ← rotation_y(π / 2)
//  Then half_quarter * p = point(√2/2, 0, √2/2)
//    And full_quarter * p = point(1, 0, 0)

    func testRotationY() {
        let p = Point(0, 0, 1)
        let halfQuarter = Matrix.rotationY(radians: CGFloat.pi / 4)
        let fullQuarter = Matrix.rotationY(radians: CGFloat.pi / 2)

        XCTAssertEqual(halfQuarter * p, Point(sqrt(2)/2, 0, sqrt(2)/2))
        XCTAssertEqual(fullQuarter * p, Point(1, 0, 0))
    }

//Scenario: Rotating a point around the z axis
//  Given p ← point(0, 1, 0)
//    And half_quarter ← rotation_z(π / 4)
//    And full_quarter ← rotation_z(π / 2)
//  Then half_quarter * p = point(-√2/2, √2/2, 0)
//    And full_quarter * p = point(-1, 0, 0)

    func testRotationZ() {
        let p = Point(0, 1, 0)
        let halfQuarter = Matrix.rotationZ(radians: CGFloat.pi / 4)
        let fullQuarter = Matrix.rotationZ(radians: CGFloat.pi / 2)

        XCTAssertEqual(halfQuarter * p, Point(-sqrt(2)/2, sqrt(2)/2, 0))
        XCTAssertEqual(fullQuarter * p, Point(-1, 0, 0))
    }

//Scenario: A shearing transformation moves x in proportion to y
//  Given transform ← shearing(1, 0, 0, 0, 0, 0)
//    And p ← point(2, 3, 4)
//  Then transform * p = point(5, 3, 4)

    func testShearingXY() {
        let matrix = Matrix.shearing(1, 0, 0, 0, 0, 0)
        let p = Point(2, 3, 4)

        XCTAssertEqual(matrix * p, Point(5, 3, 4))
    }

//Scenario: A shearing transformation moves x in proportion to z
//  Given transform ← shearing(0, 1, 0, 0, 0, 0)
//    And p ← point(2, 3, 4)
//  Then transform * p = point(6, 3, 4)

    func testShearingXZ() {
        let matrix = Matrix.shearing(0, 1, 0, 0, 0, 0)
        let p = Point(2, 3, 4)

        XCTAssertEqual(matrix * p, Point(6, 3, 4))
    }

//Scenario: A shearing transformation moves y in proportion to x
//  Given transform ← shearing(0, 0, 1, 0, 0, 0)
//    And p ← point(2, 3, 4)
//  Then transform * p = point(2, 5, 4)

    func testShearingYX() {
        let matrix = Matrix.shearing(0, 0, 1, 0, 0, 0)
        let p = Point(2, 3, 4)

        XCTAssertEqual(matrix * p, Point(2, 5, 4))
    }

//Scenario: A shearing transformation moves y in proportion to z
//  Given transform ← shearing(0, 0, 0, 1, 0, 0)
//    And p ← point(2, 3, 4)
//  Then transform * p = point(2, 7, 4)

    func testShearingYZ() {
        let matrix = Matrix.shearing(0, 0, 0, 1, 0, 0)
        let p = Point(2, 3, 4)

        XCTAssertEqual(matrix * p, Point(2, 7, 4))
    }

//Scenario: A shearing transformation moves z in proportion to x
//  Given transform ← shearing(0, 0, 0, 0, 1, 0)
//    And p ← point(2, 3, 4)
//  Then transform * p = point(2, 3, 6)

    func testShearingZX() {
        let matrix = Matrix.shearing(0, 0, 0, 0, 1, 0)
        let p = Point(2, 3, 4)

        XCTAssertEqual(matrix * p, Point(2, 3, 6))
    }

//Scenario: A shearing transformation moves z in proportion to y
//  Given transform ← shearing(0, 0, 0, 0, 0, 1)
//    And p ← point(2, 3, 4)
//  Then transform * p = point(2, 3, 7)

    func testShearingZY() {
        let matrix = Matrix.shearing(0, 0, 0, 0, 0, 1)
        let p = Point(2, 3, 4)

        XCTAssertEqual(matrix * p, Point(2, 3, 7))
    }

//Scenario: Individual transformations are applied in sequence
//  Given p ← point(1, 0, 1)
//    And A ← rotation_x(π / 2)
//    And B ← scaling(5, 5, 5)
//    And C ← translation(10, 5, 7)
//  # apply rotation first
//  When p2 ← A * p
//  Then p2 = point(1, -1, 0)
//  # then apply scaling
//  When p3 ← B * p2
//  Then p3 = point(5, -5, 0)
//  # then apply translation
//  When p4 ← C * p3
//  Then p4 = point(15, 0, 7)

    func testTransformationSequence1() {
        let p = Point(1, 0, 1)
        let a = Matrix.rotationX(radians: CGFloat.pi / 2)
        let b = Matrix.scaling(point: Point(5, 5, 5))
        let c = Matrix.translation(Point(10, 5, 7))

        let p2 = a * p
        XCTAssertEqual(p2, Point(1, -1, 0))

        let p3 = b * p2
        XCTAssertEqual(p3, Point(5, -5, 0))

        let p4 = c * p3
        XCTAssertEqual(p4, Point(15, 0, 7))
    }

// Scenario: Chained transformations must be applied in reverse order
//  Given p ← point(1, 0, 1)
//    And A ← rotation_x(π / 2)
//    And B ← scaling(5, 5, 5)
//    And C ← translation(10, 5, 7)
//  When T ← C * B * A
//  Then T * p = point(15, 0, 7)

    func testReverseChainedTransformations() {
        let p = Point(1, 0, 1)
        let a = Matrix.rotationX(radians: CGFloat.pi / 2)
        let b = Matrix.scaling(point: Point(5, 5, 5))
        let c = Matrix.translation(Point(10, 5, 7))

        let t = c * b * a
        XCTAssertEqual(t * p, Point(15, 0, 7))
    }

// Scenario: The transformation matrix for the default orientation
//  Given from ← point(0, 0, 0)
//    And to ← point(0, 0, -1)
//    And up ← vector(0, 1, 0)
//  When t ← view_transform(from, to, up)
//  Then t = identity_matrix

    func testDefaultOrientationTransform() {
        let from = Point(0, 0, 0)
        let to = Point(0, 0, -1)
        let up = Vector(0, 1, 0)

		let t = Matrix.viewTransform(from: from, to: to, up: up)
		XCTAssertEqual(t, Matrix.identity)
    }

// Scenario: A view transformation matrix looking in positive z direction
//  Given from ← point(0, 0, 0)
//    And to ← point(0, 0, 1)
//    And up ← vector(0, 1, 0)
//  When t ← view_transform(from, to, up)
//  Then t = scaling(-1, 1, -1)

	func testViewTransformLookingInPositiveZ() {
		let from = Point(0, 0, 0)
		let to = Point(0, 0, 1)
		let up = Vector(0, 1, 0)

		let t = Matrix.viewTransform(from: from, to: to, up: up)
		XCTAssertEqual(t, Matrix.scaling(point: Point(-1, 1, -1)))
 }

// Scenario: The view transformation moves the world
//  Given from ← point(0, 0, 8)
//    And to ← point(0, 0, 0)
//    And up ← vector(0, 1, 0)
//  When t ← view_transform(from, to, up)
//  Then t = translation(0, 0, -8)

	func testViewTransformMovesWorld() {
		let from = Point(0, 0, 8)
		let to = Point(0, 0, 0)
		let up = Vector(0, 1, 0)

		let t = Matrix.viewTransform(from: from, to: to, up: up)
		XCTAssertEqual(t, Matrix.translation(Point(0, 0, -8)))
	}

// Scenario: An arbitrary view transformation
//  Given from ← point(1, 3, 2)
//    And to ← point(4, -2, 8)
//    And up ← vector(1, 1, 0)
//  When t ← view_transform(from, to, up)
//  Then t is the following 4x4 matrix:
//      | -0.50709 | 0.50709 |  0.67612 | -2.36643 |
//      |  0.76772 | 0.60609 |  0.12122 | -2.82843 |
//      | -0.35857 | 0.59761 | -0.71714 |  0.00000 |
//      |  0.00000 | 0.00000 |  0.00000 |  1.00000 |

	func testAnArbitraryViewTransform() {
		let from = Point(1, 3, 2)
		let to = Point(4, -2, 8)
		let up = Vector(1, 1, 0)

		let t = Matrix.viewTransform(from: from, to: to, up: up)

		XCTAssertEqual(t[0,0], -0.50709, accuracy: CGFloat.epsilon)
		XCTAssertEqual(t[0,1], 0.50709, accuracy: CGFloat.epsilon)
		XCTAssertEqual(t[0,2], 0.67612, accuracy: CGFloat.epsilon)
		XCTAssertEqual(t[0,3], -2.36643, accuracy: CGFloat.epsilon)
		XCTAssertEqual(t[1,0], 0.76772, accuracy: CGFloat.epsilon)
		XCTAssertEqual(t[1,1], 0.60609, accuracy: CGFloat.epsilon)
		XCTAssertEqual(t[1,2], 0.12122, accuracy: CGFloat.epsilon)
		XCTAssertEqual(t[1,3], -2.82843, accuracy: CGFloat.epsilon)
		XCTAssertEqual(t[2,0], -0.35857, accuracy: CGFloat.epsilon)
		XCTAssertEqual(t[2,1], 0.59761, accuracy: CGFloat.epsilon)
		XCTAssertEqual(t[2,2], -0.71714, accuracy: CGFloat.epsilon)
		XCTAssertEqual(t[2,3], 0, accuracy: CGFloat.epsilon)
		XCTAssertEqual(t[3,0], 0, accuracy: CGFloat.epsilon)
		XCTAssertEqual(t[3,1], 0, accuracy: CGFloat.epsilon)
		XCTAssertEqual(t[3,2], 0, accuracy: CGFloat.epsilon)
		XCTAssertEqual(t[3,3], 1, accuracy: CGFloat.epsilon)
	}
}
