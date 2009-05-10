//
//  settings.h
//  dtmfdecode
//
//  Created by Veghead on 09/05/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface settings : UIView {
	id *masterController;
}

@property (readwrite, assign) id *masterController;
- (IBAction) backButtonPressed;
@end
