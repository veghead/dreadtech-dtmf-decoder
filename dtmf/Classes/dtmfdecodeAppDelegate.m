//
//  dtmfdecodeAppDelegate.m
//  dtmfdecode
//
//  Created by Veghead on 14/11/2008.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "dtmfdecodeAppDelegate.h"
#import "dtmfdecodeViewController.h"

@implementation dtmfdecodeAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
