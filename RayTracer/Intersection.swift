//
//  Intersection.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 2/17/21.
//  Copyright © 2021 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

public struct Intersection: Identifiable, Equatable {
    public static func == (lhs: Intersection, rhs: Intersection) -> Bool {
        return((lhs.distance == rhs.distance) && (lhs.shape.id == rhs.shape.id))
    }

    public var id = UUID()
    public let distance: CGFloat
    public let shape: Shape
    public let time: CGFloat
    
}
