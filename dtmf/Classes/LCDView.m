//
//  LCDView.m
//  dtmfdecode
//
//  Created by Veghead on 22/11/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "LCDView.h"


@implementation LCDView

//@synthesize a,b,c,d,e,f,g,h,i,j,k,l,m,n,o;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}


- (void)setLCDString:(char*)content {
	if (strlen(content) > LCD_COLS) {
		content = content + (strlen(content)-LCD_COLS);
	}
	UIImageView *disp[LCD_COLS] = {a,b,c,d,e,f,g,h,i,j,k,l,m,n,o};
	for (int in = 0; in < LCD_COLS; in++) {
		[disp[in] setImage:[self charToImage:*content]];
		if (*content) content++;
	}
}


- (void)setLEDs:(int)bin {
	UIImageView *disp[8] = {la,lb,lc,ld,le,lf,lg,lh};
	for (int in = 0; in < 8; in++) {
		bool onoff = (0 == (bin & 1));
		[disp[in] setHidden:onoff];
		bin >>= 1;	
	}	
}


- (UIImage *)charToImage:(char) chr
{
	if (isdigit(chr) || (chr == 'A') || (chr == 'B') || (chr == 'C') || (chr == 'D')
			|| (chr == '*') || (chr == '#')) {
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
