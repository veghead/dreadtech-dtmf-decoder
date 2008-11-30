//
//  dtmfdecodeAppDelegate.h
//  dtmfdecode
//
//  Created by Veghead on 14/11/2008.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class dtmfdecodeViewController;

@interface dtmfdecodeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    dtmfdecodeViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet dtmfdecodeViewController *viewController;

@end

