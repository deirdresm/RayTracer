//
//  Ray.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 2/16/21.
//  Copyright © 2021 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation
import CoreGraphics

// swiftlint:disable identifier_name

public struct Ray: Equatable {
    var origin: Point
    var direction: Vector
    var intersections: [Intersection] = []

    init(origin: Point, direction: Vector) {
        self.origin = origin
        self.direction = direction
    }

    func position(_ time: CGFloat) -> Point {
        return self.origin + (self.direction * time)
    }

    func transform(_ matrix: Matrix) -> Ray {
        let o: Point = matrix * origin
        let d: Vector = matrix * direction
        let r = Ray(origin: o, direction: d)
        return r
    }

    func hit() -> Intersection? {
        if intersections.count == 0 { return nil }

        let hits = intersections.filter { $0.distance > 0 }

        if hits.count > 0 {
            return hits.sorted().first
        } else {
            return nil
        }
    }
}
