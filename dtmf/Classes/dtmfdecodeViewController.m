//
//  dtmfdecodeViewController.m
//  dtmfdecode
//
//  Created by Veghead on 14/11/2008.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "dtmfdecodeViewController.h"
@implementation dtmfdecodeViewController

@synthesize lcdBuffer, data, decoder, settingsViewController;
/*
// Override initWithNibName:bundle: to load the view using a nib file then perform additional customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self.view setNeedsLayout];
	DTMFDecoder *dec = [[DTMFDecoder alloc] init];
	[dec setDTMF:1];
	[self setDecoder:dec];
	//NSData *d = [NSData dataWithContentsOfRL:[NSURL URLWithString:@"http://fatsquirrel.org/dtmf.raw"]];
	//UInt16 *dod = (UInt16 *)[d bytes];
	//for (int i = 0; i < [d length]/2; i++) {
	//	[self.decoder goertzel:dod[i]];
	//}
	//[self setData:d];
	[(LCDView *)self.view setLCDString:[self.decoder detectBuffer]];
	UIViewController *viewController = [[UIViewController alloc] initWithNibName:@"settings" bundle:nil];
	self.settingsViewController = viewController;
	[(settings *)settingsViewController.view setMasterController:(id *)self];
	[viewController release];
	
	[NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(tick:) userInfo:self repeats:YES];	
}



- (void) tick: (NSTimer *)timer
{
	[(LCDView *)self.view setLCDString:[self.decoder detectBuffer]];
	[(LCDView *)self.view setLEDs:[self.decoder ledbin]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)flipToSettings {
	settings *settingsView = (settings *)settingsViewController.view;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
	[settingsViewController viewWillAppear:YES];
	[self viewWillDisappear:YES];
	[self.view addSubview:settingsView];
	[self viewDidDisappear:YES];
	[settingsViewController viewDidAppear:YES];
	[UIView commitAnimations];
}

- (void)dealloc {
    [super dealloc];
}

- (IBAction) modeButtonPressed
{
}

- (IBAction) sendButtonPressed 
{
}

- (IBAction) settingsButtonPressed 
{
	NSLog(@"SETUP");
	[self flipToSettings];
}


- (IBAction) clearButtonPressed
{
	NSLog(@"clear pressed");
	[self.decoder resetBuffer];
}
- (void) flipBack
{
	NSLog(@"flipBack");
	settings *settingsView = (settings *)settingsViewController.view;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
	[settingsViewController viewWillDisappear:YES];
	[self viewWillAppear:YES];
	[settingsView removeFromSuperview];
	[settingsViewController viewDidDisappear:YES];
	[self viewDidAppear:YES];
	[UIView commitAnimations];
}
@end
