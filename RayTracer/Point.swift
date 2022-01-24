//
//  Point.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 2/26/19.
//  Copyright © 2019 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name

public final class Point: Tuple {

	required init(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat, _ w: CGFloat) {
		super.init(x, y, z, 1.0)
	}

	init(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat) {
		super.init(x, y, z, 1.0)
	}

	public override var description: String {

        return("Point: x: \(formatted(x)), y: \(formatted(y)), z: \(formatted(z)), w: \(formatted(w))")
	}

	var formatter: NumberFormatter {
		 let formatter = NumberFormatter()
		 formatter.numberStyle = .decimal
		 formatter.maximumFractionDigits = 3
		 return formatter
	 }

	 func formatted(_ num: CGFloat) -> String {
		 let num2: NSNumber = NSNumber(value: Float(num))
		 let fs = formatter.string(from: num2)
		 return fs!
	 }
}
