//
//  PPMFileFormat.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 3/25/19.
//  Copyright © 2019 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

class PPMFileFormat : NSObject {
	var fileOutput = ""
	var canvas : Canvas!
	
	convenience init(_ canvas: Canvas) {
		self.init()
		self.canvas = canvas
		
		writeHeader()
	}
	
	func writeHeader() {
		fileOutput = "P3\n\(canvas.width) \(canvas.height)\n255\n"
	}
}
