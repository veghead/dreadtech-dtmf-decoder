//
//  dtmfdecodeViewController.m
//  dtmfdecode
//
//  Created by Veghead on 14/11/2008.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "dtmfdecodeViewController.h"
g@implementation dtmfdecodeViewController

@synthesize lcdBuffer, data, decoder;
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
	[NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(tick:) userInfo:self repeats:YES];	
}



- (void) tick: (NSTimer *)timer
{
	[(LCDView *)self.view setLCDString:[self.decoder detectBuffer]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
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

- (IBAction) clearButtonPressed
{
	NSLog(@"clear pressed");
	[self.decoder resetBuffer];
}

@end
