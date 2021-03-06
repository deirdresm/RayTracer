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

    func intersect(_ ray: Ray) -> [Intersection]

}
