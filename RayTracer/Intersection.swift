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

    // MARK: - Equatable/Comparable conformance

    public static func < (lhs: Intersection, rhs: Intersection) -> Bool {
        return(lhs.distance < rhs.distance)
    }

    public static func == (lhs: Intersection, rhs: Intersection) -> Bool {
        return((lhs.distance == rhs.distance) && (lhs.shape.id == rhs.shape.id))
    }

    public var id = UUID()
    public let distance: CGFloat
    public let shape: Shape
}
