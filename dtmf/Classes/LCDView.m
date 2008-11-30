//
//  LCDView.m
//  dtmfdecode
//
//  Created by Veghead on 22/11/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "LCDView.h"


@implementation LCDView

@synthesize a,b,c,d,e,f,g,h,i,j,k,l,m,n,o;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}

- (void)setLCDString:(char*)content {
	if (strlen(content) > 15) {
		content = content + (strlen(content)-15);
	}
	[a setImage:[self charToImage:*content]];
	if (*content) content++;
	[b setImage:[self charToImage:*content]];
	if (*content) content++;
	[c setImage:[self charToImage:*content]];
	if (*content) content++;
	[d setImage:[self charToImage:*content]];
	if (*content) content++;
	[e setImage:[self charToImage:*content]];
	if (*content) content++;
	[f setImage:[self charToImage:*content]];
	if (*content) content++;
	[g setImage:[self charToImage:*content]];
	if (*content) content++;
	[h setImage:[self charToImage:*content]];
	if (*content) content++;
	[i setImage:[self charToImage:*content]];
	if (*content) content++;
	[j setImage:[self charToImage:*content]];
	if (*content) content++;
	[k setImage:[self charToImage:*content]];
	if (*content) content++;
	[l setImage:[self charToImage:*content]];
	if (*content) content++;
	[m setImage:[self charToImage:*content]];
	if (*content) content++;
	[n setImage:[self charToImage:*content]];
	if (*content) content++;
	[o setImage:[self charToImage:*content]];
}


- (UIImage *)charToImage:(char) chr
{
	if (isdigit(chr)) {
		char name[10];
		snprintf(name,10,"%c.png",chr);
		return [UIImage imageNamed:[[NSString alloc] initWithCString:name]];	
	}
	return nil;
}


- (void)drawRect:(CGRect)rect {

	NSLog(@"helloll");

    // Drawing code
}


- (void)dealloc {
    [super dealloc];
}


@end
