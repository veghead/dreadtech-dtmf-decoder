//
//  dtmfdecodeViewController.h
//  dtmfdecode
//
//  Created by Veghead on 14/11/2008.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCDView.h"
#import "DTMFDecoder.h"
#import "settings.h"

@interface dtmfdecodeViewController : UIViewController {
	char *lcdBuffer;
	int mode;
	NSData *data;
	DTMFDecoder *decoder;
	UIViewController *settingsViewController;
}

@property (nonatomic, retain) UIViewController *settingsViewController;
@property (readwrite, retain) DTMFDecoder *decoder;
@property (readwrite, assign) NSData *data;
@property (readwrite, assign) char *lcdBuffer;

- (IBAction) modeButtonPressed;
- (IBAction) sendButtonPressed;
- (IBAction) settingsButtonPressed;
- (IBAction) clearButtonPressed;
- (void) flipToSettings;
- (void) tick: (NSTimer *)timer;

@end

