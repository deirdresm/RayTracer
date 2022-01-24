//
//  Vector.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 2/26/19.
//  Copyright © 2019 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name

public class Vector: Tuple {

	required init(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat, _ w: CGFloat) {
		super.init(x, y, z, 0.0)
	}

	init(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat) {
		super.init(x, y, z, 0.0)
	}

	public override var description: String {
		return("Vector: x: \(x), y: \(y), z: \(z), w: \(w)")
	}
}
