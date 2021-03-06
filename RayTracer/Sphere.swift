//
//  Sphere.swift
//  RayTracerTests
//
//  Created by Deirdre Saoirse Moen on 2/16/21.
//  Copyright © 2021 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name

class Sphere: Shape, Equatable {
    var id = UUID()
    var origin: Point
    var radius: CGFloat
    var transform: Matrix

    init(origin: Point = Point(0, 0, 0), radius: CGFloat = 1.0, transform: Matrix = Matrix.identity) {
        self.origin = origin
        self.radius = radius
        self.transform = transform
    }

    // 
    func intersect(_ ray: Ray) -> [Intersection] {
        let sphereToRay = ray.origin - Point(0, 0, 0)

        let a = ray.direction • ray.direction
        let b = 2 * (ray.direction • sphereToRay)
        let c = (sphereToRay • sphereToRay) - 1

        let discriminant = (b * b) - (4 * a * c)

        if discriminant > 0 {
            let t1 = (-b - sqrt(discriminant)) / (2 * a)
            let t2 = (-b + sqrt(discriminant)) / (2 * a)

            let t1i = Intersection(distance: t1, shape: self)
            let t2i = Intersection(distance: t2, shape: self)

            return [t1i, t2i]
        } else if discriminant == 0 { // perfect tangent
            let t1 = (-b - sqrt(discriminant)) / (2 * a)
            let t1i = Intersection(distance: t1, shape: self)
            return [t1i, t1i]
        }

        return []
    }

    func setTransform(_ transform: Matrix) {
        self.transform = transform
    }

    static func == (lhs: Sphere, rhs: Sphere) -> Bool {
        return lhs.id == rhs.id
    }
}
