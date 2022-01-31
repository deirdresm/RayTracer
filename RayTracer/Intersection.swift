//
//  Intersection.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 2/17/21.
//  Copyright © 2021 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name

// note: book uses t for the distance parameter; I named it the
// same as it was in the Ray structure.

public struct Intersection: Identifiable, Equatable, Comparable {
	public var id = UUID()
	public let distance: CGFloat
	public let shape: Shape

    // MARK: - Equatable/Comparable conformance

    public static func < (lhs: Intersection, rhs: Intersection) -> Bool {
        return(lhs.distance < rhs.distance)
    }

    public static func == (lhs: Intersection, rhs: Intersection) -> Bool {
        return((lhs.distance == rhs.distance) && (lhs.shape.id == rhs.shape.id))
    }

	// MARK: - Convenience methods

	static func hit(by intersections: [Intersection]) -> Intersection? {
		let sorted = intersections.sorted()

		if sorted.count >= 0 {
			for intersection in sorted {
				if intersection.distance > 0 {
					return intersection
				}
			}
			// all hits were negative (behind the ray's origin)
			return .none
		}
		// no items, so no hit
		return .none
	}
}

public struct IntersectionState: Equatable {
	let intersection: Intersection
	let ray: Ray
	let point: Point
	let overPoint: Point
	let eyeV: Vector
	let normalV: Vector
	let isInside: Bool

	init(intersection: Intersection, ray: Ray) {
		self.intersection = intersection
		self.ray = ray
		self.point = ray.position(intersection.distance)
		self.eyeV = -ray.direction
		let normalV: Vector = intersection.shape.normal(at: self.point)

		if normalV • self.eyeV < 0 {
			self.isInside = true
			self.normalV = -normalV
		} else {
			self.isInside = false
			self.normalV = normalV
		}
		self.overPoint = self.point + self.normalV * CGFloat.epsilon
	}

	var shape: Shape {
		return intersection.shape
	}

	var distance: CGFloat {
		return intersection.distance
	}
}
