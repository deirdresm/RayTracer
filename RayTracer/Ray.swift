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

    init(origin: Point, direction: Vector) {
        self.origin = origin
        self.direction = direction
    }

    func position(_ time: CGFloat) -> Point {
        return self.origin + (self.direction * time)
    }

    func transform(_ matrix: Matrix) -> Ray {

        let o: Point = matrix * origin as! Point
        let d: Vector = matrix * direction as! Vector
        let r = Ray(origin: o, direction: d)
        return r
    }

}
