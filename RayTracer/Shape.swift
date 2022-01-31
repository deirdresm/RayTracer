//
//  Shape.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 2/17/21.
//  Copyright © 2021 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name

public protocol Shape {
    var id: UUID { get }
	var material: Material { get set }
	var transform: Matrix { get set }
	var description: String { get }

    func intersections(_ ray: Ray) -> [Intersection]

	func normal(at worldPoint: Point) -> Vector
}
