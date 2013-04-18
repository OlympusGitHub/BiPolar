//
//  AppDelegate.h
//  Gyrus2
//
//  Created by James Hollender on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gyrus2Model.h"
#import "FirstViewController_iPad.h"
#import "MenuViewController.h"
#import "MenuViewController_iPad.h"

#define OLYMPUS_BLUE [UIColor colorWithRed:12.0/255.0 green:77.0/255.0 blue:162.0/255.0 alpha:1.0]

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) Gyrus2Model *gyrus2model;
@property (strong, nonatomic) NSString *stringTitle;
@property (assign) BOOL fromAuthorsPage;
@property (assign) BOOL iPadDevice;

@end
