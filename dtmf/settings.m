//
//  settings.m
//  dtmfdecode
//
//  Created by Veghead on 09/05/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "settings.h"


@implementation settings
@synthesize masterController;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)dealloc {
    [super dealloc];
}

- (IBAction) backButtonPressed
{
	NSLog(@"back");
	[masterController flipBack];
}


@end
