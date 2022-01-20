//
//  Example.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 4/6/19.
//  Copyright © 2019 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation
import AppKit

// swiftlint:disable identifier_name

class Example : NSObject {

    let docDir : URL = {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }()

    private static var decimalFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 3
            return formatter
    }()

    // TODO: needs clamping for out-of-bounds errors.

    func writeRenderedFile(canvas: Canvas, fileName: String) {
        let rendered = PPMFileFormat(canvas)
        let fileNamePath = docDir.appendingPathComponent(fileName).path

        if FileManager.default.fileExists(atPath: fileNamePath) {
            try! FileManager.default.removeItem(at: docDir.appendingPathComponent(fileName))
        }
        FileManager.default.createFile(atPath: fileNamePath, contents: rendered.fileOutput.data(using: String.Encoding.utf8), attributes: nil)
    }

    func makeCurve(width: Int, height: Int) {

        let startPoint = Point(0, 1, 0)

        let saturation : CGFloat = 0.9
        let brightness : CGFloat = 0.9
        let alpha : CGFloat = 1.0
        var currentHue : CGFloat = 0.0

		let v = Vector(1, 1.8, 0)

		let velocity : Vector = v.normalize() * 11.25
        let gravity = Vector(0, -0.098, 0)
        let wind = Vector(-0.01, 0, 0)
        var p = Projectile(position: startPoint, velocity: velocity)
        let e = Environment(gravity: gravity, wind: wind)
        var c = Canvas(width, height)

        var areWeDoneYet = false

        repeat {
            currentHue = p.position.x / CGFloat(width)
            let nsColor = NSColor(colorSpace: .deviceRGB, hue: currentHue, saturation: saturation, brightness: brightness, alpha: alpha)
            let color = VColor(nsColor: nsColor)

            c.writePixel(Int(p.position.x), height - Int(p.position.y), color)

            // calc next position
            p.tick(environment: e)

            areWeDoneYet = !(Int(p.position.x) < (width - 1))
        } while !areWeDoneYet

        writeRenderedFile(canvas: c, fileName: "makeCurve.ppm")
    }

    func makeClock(width: Int, height: Int) {
        let startPoint = Point(CGFloat(width / 2), CGFloat(height / 2), 0)
        var c = Canvas(width, height)
        var currentHue : CGFloat = 0.0

        let saturation : CGFloat = 0.95
        let brightness : CGFloat = 0.95
        let alpha : CGFloat = 1.0

        // scale to be 70% of the size of the smaller of width/height
        let radius = width > height ? 0.35 * CGFloat(height) : 0.35 * CGFloat(width)

        for hour in 1 ... 12 {
            currentHue = CGFloat(hour) / 12.0
            let nsColor = NSColor(colorSpace: .deviceRGB, hue: currentHue, saturation: saturation, brightness: brightness, alpha: alpha)
            let color = VColor(nsColor: nsColor)

            let x = cos(currentHue * 2 * CGFloat.pi)
            let y = sin(currentHue * 2 * CGFloat.pi)

            let x2 = startPoint.x + radius * x
            let y2 = startPoint.y + radius * y

            let r = Matrix.rotationY(radians: CGFloat(hour/6) * CGFloat.pi) // per hint #3
            let rm = r * Point(x, 0, y)

            c.writePixel(Int(x2), height - Int(y2), color)
        }

        writeRenderedFile(canvas: c, fileName: "makeClock.ppm")
    }

    // End of Chapter 4 project

    // TODO: this is actually upsided-down and rotated, not merely rotated
    func makeClock2(width: Int, height: Int) {
        let startPoint = Point(CGFloat(width / 2), CGFloat(height / 2), 0)
        var c = Canvas(width, height)
        var currentHour : CGFloat = 0.0

        let saturation : CGFloat = 0.95
        let brightness : CGFloat = 0.95
        let alpha : CGFloat = 1.0

        var formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3

        // scale to be 85% of the size of the smaller of width/height
        let radius = width > height ? 0.425 * CGFloat(height) : 0.425 * CGFloat(width)

        for hour in 1 ... 12 {
            currentHour = CGFloat(hour) / 12.0

            let nsColor = NSColor(colorSpace: .deviceRGB, hue: currentHour, saturation: saturation, brightness: brightness, alpha: alpha)
            let color = VColor(nsColor: nsColor)

            // this is just the relative position, needs to be
            // scaled for the canvas size

            let r = Matrix.rotationY(radians: currentHour * 2.0 * CGFloat.pi) // per hint #3
            let rm = r * Point(0, 0, 1)

            let x2 = startPoint.x + radius * rm.x
            let y2 = startPoint.y + radius * rm.z

            c.writePixel(Int(x2), height - Int(y2), color)
        }

        writeRenderedFile(canvas: c, fileName: "makeRotatedClock.ppm")
    }
	// End of Chapter 4 project

	// TODO: incomplete
	func makeSphericalSilhouette(width: Int) {
		let rayOrigin = Point(CGFloat(width / 2), CGFloat(width / 2), -5)
		let wallZ = 10
		let wallSize = 8
		let pixelSize = width / wallSize
		let half = width / 2

		let purple = VColor(1, 1, 0)
		let shape = Sphere()

		var c = Canvas(width, width)

		for y in 0 ..< width {
			let worldY = half - pixelSize * y

			for x in 0 ..< width {
				let worldX = -half + pixelSize * x
				let position = Point(CGFloat(worldX), CGFloat(worldY), CGFloat(wallZ))

				let direction = position - rayOrigin

				let r = Ray(origin: rayOrigin,
							direction: direction.normalize() as! Vector
				)
			}
		}

		writeRenderedFile(canvas: c, fileName: "sphericalSilhouette.ppm")
	}
}
