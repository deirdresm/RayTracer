//
//  AppDelegate.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 9/12/18.
//  Copyright © 2018 Deirdre Saoirse Moen. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application

		let example = Example()
		example.makeCurve(width: 900, height: 600)
        example.makeClock(width: 900, height: 600)
        example.makeClock2(width: 900, height: 600)

//		let sphere = DrawSphere()
//		sphere.makeSphericalSilhouette(width: 600)
    }
}
