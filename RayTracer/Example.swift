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

    // TODO: needs clamping for out-of-bounds errors.

    func makeCurve(width: Int, height: Int) {

        let startPoint = Point(0, 1, 0)

        let saturation : CGFloat = 0.9
        let brightness : CGFloat = 0.9
        let alpha : CGFloat = 1.0
        var currentHue : CGFloat = 0.0

        let velocity : Vector = Vector(1, 1.8, 0).normalize()*11.25
        let gravity = Vector(0, -0.098, 0)
        let wind = Vector(-0.01, 0, 0)
        var p = Projectile(position: startPoint, velocity: velocity)
        let e = Environment(gravity: gravity, wind: wind)
        var c = Canvas(width, height)

        var areWeDoneYet = false

        repeat {
            currentHue = p.position.x / CGFloat(width)
            let nsColor = NSColor(colorSpace: .deviceRGB, hue: currentHue, saturation: saturation, brightness: brightness, alpha: alpha)
            let color = Color(nsColor: nsColor)

            c.writePixel(Int(p.position.x), height - Int(p.position.y), color)

            // calc next position
            p.tick(environment: e)

            areWeDoneYet = !(Int(p.position.x) < (width - 1))
        } while !areWeDoneYet


        let rendered = PPMFileFormat(c)
        let fileName = "makeCurve.ppm"
        print(docDir.appendingPathComponent(fileName).path)

        let fileNamePath = docDir.appendingPathComponent(fileName).path

        if FileManager.default.fileExists(atPath: fileNamePath) {
            try! FileManager.default.removeItem(at: docDir.appendingPathComponent(fileName))
        }
        FileManager.default.createFile(atPath: fileNamePath, contents: rendered.fileOutput.data(using: String.Encoding.utf8), attributes: nil)
    }
}
