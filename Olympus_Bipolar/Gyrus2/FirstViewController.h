//
//  FirstViewController.h
//  Gyrus2
//
//  Created by James Hollender on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoViewController.h"
#import "AppDelegate.h"

@interface FirstViewController : UIViewController

@property (assign) BOOL iPadDevice;
- (IBAction)buttonInfoTap:(id)sender;

@end
