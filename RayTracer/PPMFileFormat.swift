//
//  PPMFileFormat.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 3/25/19.
//  Copyright © 2019 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name trailing_whitespace

class PPMFileFormat: NSObject {
    var fileOutput = ""
    var canvas: Canvas!

    convenience init(_ canvas: Canvas) {
        self.init()
        self.canvas = canvas

        writeHeader()
        writeBody()
    }

    func writeHeader() {
        fileOutput = "P3\n\(canvas.width) \(canvas.height)\n255\n"
    }

    func writeBody() {
        var bodyOutput = ""

        var currentLineLength = 0

        for y in 0..<canvas.height {
            for x in 0..<canvas.width {

				let p = canvas.pixel(at: x, y)

                let r = Int(round(p.red * 255.0))
                let g = Int(round(p.green * 255.0))
                let b = Int(round(p.blue * 255.0))
                
                var temp = "\(r) \(g) \(b)"
                if currentLineLength + temp.count + 1 >= 69 {
                    temp = "\n\(r) \(g) \(b)"
                    currentLineLength = temp.count - 1
                } else {
                    
                    if x > 0 {
                        temp = " " + temp
                        currentLineLength += temp.count
                    }
                }

                bodyOutput += temp
            }
            bodyOutput += "\n"
            currentLineLength = 0
        }

        fileOutput += bodyOutput
    }
}
