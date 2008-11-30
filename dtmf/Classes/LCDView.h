//
//  LCDView.h
//  dtmfdecode
//
//  Created by Veghead on 22/11/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


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
}

@property (readwrite, retain) UIImageView *modeDisplay;
@property (readwrite, retain) UIImageView *a;
@property (readwrite, retain) UIImageView *b;
@property (readwrite, retain) UIImageView *c;
@property (readwrite, retain) UIImageView *d;
@property (readwrite, retain) UIImageView *e;
@property (readwrite, retain) UIImageView *f;
@property (readwrite, retain) UIImageView *g;
@property (readwrite, retain) UIImageView *h;
@property (readwrite, retain) UIImageView *i;
@property (readwrite, retain) UIImageView *j;
@property (readwrite, retain) UIImageView *k;
@property (readwrite, retain) UIImageView *l;
@property (readwrite, retain) UIImageView *m;
@property (readwrite, retain) UIImageView *n;
@property (readwrite, retain) UIImageView *o;

- (void)setLCDString:(char*)content;
- (UIImage *)charToImage:(char) c;
@end
