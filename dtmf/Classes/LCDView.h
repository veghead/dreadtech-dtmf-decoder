//
//  LCDView.h
//  dtmfdecode
//
//  Created by Veghead on 22/11/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define LCD_COLS 15

@interface LCDView : UIView {
	IBOutlet UIImageView *modeDisplay;
	IBOutlet UIImageView *a;
	IBOutlet UIImageView *b;
	IBOutlet UIImageView *c;
	IBOutlet UIImageView *d;
	IBOutlet UIImageView *e;
	IBOutlet UIImageView *f;
	IBOutlet UIImageView *g;
	IBOutlet UIImageView *h;
	IBOutlet UIImageView *i;
	IBOutlet UIImageView *j;
	IBOutlet UIImageView *k;
	IBOutlet UIImageView *l;
	IBOutlet UIImageView *m;
	IBOutlet UIImageView *n;
	IBOutlet UIImageView *o;

	IBOutlet UIImageView *la;
	IBOutlet UIImageView *lb;
	IBOutlet UIImageView *lc;
	IBOutlet UIImageView *ld;
	IBOutlet UIImageView *le;
	IBOutlet UIImageView *lf;
	IBOutlet UIImageView *lg;
	IBOutlet UIImageView *lh;
}

- (void)setLCDString:(char*)content;
- (void)setLEDs:(int)bin;
- (UIImage *)charToImage:(char) c;
@end
