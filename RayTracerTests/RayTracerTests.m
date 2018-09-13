//
//  RayTracerTests.m
//  RayTracerTests
//
//  Created by Deirdre Saoirse Moen on 9/12/18.
//  Copyright © 2018 Deirdre Saoirse Moen. All rights reserved.
//

#import <Foundation/Foundation.h>
//Replace CucumberishExampleUITests with the name of your swift test target
#import "RayTracerTests-Bridging-Header.h"

__attribute__((constructor))
void CucumberishInit()
{
	[CucumberishInitializer CucumberishSwiftInit];
	}
