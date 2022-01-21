//
//  FileBasics.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 1/21/22.
//  Copyright © 2022 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

extension FileManager {

	func writeRenderedFile(canvas: Canvas, fileName: String) {
		let rendered = PPMFileFormat(canvas)
		let docDir = urls(for: .documentDirectory, in: .userDomainMask).first!
		let fileURL = docDir.appendingPathComponent(fileName)

		print("Saving to: \(fileURL.path)")

		if fileExists(atPath: fileURL.path) {
			try! removeItem(at: fileURL)
		}
		createFile(atPath: fileURL.path, contents: rendered.fileOutput.data(using: String.Encoding.utf8), attributes: nil)
	}

}
