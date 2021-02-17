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

struct Ray {
    var origin: Point
    var direction: Vector

    init(origin: Point, direction: Vector) {
        self.origin = origin
        self.direction = direction
    }

    func position(_ t: CGFloat) -> Point {
        return self.origin + (self.direction * t)
    }

}
