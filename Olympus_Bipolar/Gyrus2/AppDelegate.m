//
//  AppDelegate.m
//  Gyrus2
//
//  Created by James Hollender on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstViewController.h"
#import "Outcome1ViewController.h"
#import "Procedure1ViewController.h"
#import "AuthorsViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize gyrus2model;
@synthesize stringTitle;
@synthesize fromAuthorsPage;
@synthesize iPadDevice;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

	if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
		iPadDevice = YES;		

	// Status Bar
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
	
	// Window background
	UIView *windowBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 20, iPadDevice ? 768 : 320, iPadDevice ? 1004 : 460)];
	windowBackground.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:iPadDevice ? @"Background_iPad.png" : @"Background.png"]];
	[self.window addSubview:windowBackground];
	
	if ( [[UINavigationBar class] respondsToSelector:@selector(appearance)] )
	{
		// Custom Navbar
		[[UINavigationBar appearance] setTitleTextAttributes:
		 [NSDictionary dictionaryWithObjectsAndKeys:
		  
		  [UIColor colorWithRed:255.0 / 255.0 green:189.0 / 255.0 blue:48.0 / 255.0 alpha:1.0],
		  UITextAttributeTextColor,
		  
		  [UIColor clearColor],
		  UITextAttributeTextShadowColor,
		  
		  [NSValue valueWithUIOffset:UIOffsetMake(0, 1)],
		  UITextAttributeTextShadowOffset,
		  
		  [UIFont fontWithName:@"Helvetica-Bold" size:20.0],
		  UITextAttributeFont,
		  
		  nil]];

		UIImage *NavigationPortraitBackground = [[UIImage imageNamed:@"NavBar_Gradient.png"] 
												 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
		
		[[UINavigationBar appearance] setBackgroundImage:NavigationPortraitBackground 
										   forBarMetrics:UIBarMetricsDefault];
	}
	
	if ( [[UIToolbar class] respondsToSelector:@selector(appearance)] )
	{
		// Custom Toolbar		
		UIImage *toolbarBackground = [[UIImage imageNamed:@"ToolBar_Gradient.png"] 
									  resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
		
		[[UIToolbar appearance] setBackgroundImage:toolbarBackground forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
	}
	
	if ( [[UISegmentedControl class] respondsToSelector:@selector(appearance)] )
	{
		// Custom Segmented Control
		[[UISegmentedControl appearance] setTitleTextAttributes:
		 [NSDictionary dictionaryWithObjectsAndKeys:
		  
		  OLYMPUS_BLUE,
		  UITextAttributeTextColor,
		  
		  [UIColor clearColor],
		  UITextAttributeTextShadowColor,
		  
		  [NSValue valueWithUIOffset:UIOffsetMake(0, 1)],
		  UITextAttributeTextShadowOffset,
		  
		  [UIFont fontWithName:@"Helvetica-Bold" size:12.0],
		  UITextAttributeFont,
		  
		  nil] 
													   forState:UIControlStateNormal];
	}
	
	// - (void)setTitleTextAttributes:(NSDictionary *)attributes forState:(UIControlState)state
	
//	UIViewController *viewController1;
//	
//	if ( iPadDevice == YES )
//		viewController1 = [[FirstViewController_iPad alloc] initWithNibName:@"FirstViewController_iPad" bundle:nil];
//	else
//		viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
//	
//	Outcome1ViewController *viewController2 = [[Outcome1ViewController alloc] initWithNibName:@"Outcome1ViewController" bundle:nil];
//	Procedure1ViewController *viewController3 = [[Procedure1ViewController alloc] initWithNibName:@"Procedure1ViewController" bundle:nil];
//	AuthorsViewController *viewController4 = [[AuthorsViewController alloc] initWithNibName:@"AuthorsViewController" bundle:nil];
//	
//	[viewController1 setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Home" image:[UIImage imageNamed:@"infoTabIcon.png"] tag:1]];
//	
//	UINavigationController *navController2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
//	[navController2 setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Outcomes" image:[UIImage imageNamed:@"outcomeTabIcon.png"] tag:2]];
//	[navController2.navigationBar.topItem setTitle:@"Outcomes"]; 
//	[navController2.navigationBar setTintColor:OLYMPUS_BLUE];
//	
//	UINavigationController *navController3 = [[UINavigationController alloc] initWithRootViewController:viewController3];
//	[navController3 setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Procedures" image:[UIImage imageNamed:@"procedureTabIcon.png"] tag:3]];
//	[navController3.navigationBar.topItem setTitle:@"Procedures"]; 
//	[navController3.navigationBar setTintColor:OLYMPUS_BLUE];
//	
//	UINavigationController *navController4 = [[UINavigationController alloc] initWithRootViewController:viewController4];
//	[navController4 setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Article Index" image:[UIImage imageNamed:@"indexTabIcon.png"] tag:4]];
//	[navController4.navigationBar.topItem setTitle:@"Article Index"]; 
//	[navController4.navigationBar setTintColor:OLYMPUS_BLUE];
//	
//	self.tabBarController = [[UITabBarController alloc] init];
//	self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, navController2, navController3, navController4, nil];
	
//	self.window.rootViewController = self.tabBarController;
//	self.window.rootViewController = menuNavigationController;
	
	MenuViewController_iPad *menuViewController_iPad;
	MenuViewController *menuViewController;
	
	if ( iPadDevice ) 
	{
		menuViewController_iPad = [[MenuViewController_iPad alloc] initWithNibName:@"MenuViewController_iPad" bundle:nil];
	} else {
		menuViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
	}
		
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:iPadDevice ? menuViewController_iPad : menuViewController];
	
	navController.navigationBarHidden = YES;
	navController.navigationBar.tintColor = OLYMPUS_BLUE;
//	navController.navigationBar.tintColor = [UIColor colorWithRed:34.0 / 255.0 green:106.0 / 255.0 blue:162.0 / 255.0 alpha:1.0];

	self.window.rootViewController = navController;
	
    [self.window makeKeyAndVisible];
	
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	/*
	 Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	 Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	 */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	/*
	 Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	 If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	 */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	/*
	 Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	 */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	/*
	 Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	 */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	/*
	 Called when the application is about to terminate.
	 Save data if appropriate.
	 See also applicationDidEnterBackground:.
	 */
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
