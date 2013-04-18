//
//  FirstViewController_iPad.m
//  Gyrus2
//
//  Created by James Hollender on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController_iPad.h"

@interface FirstViewController_iPad ()

@end

@implementation FirstViewController_iPad

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)buttonInfoTap:(id)sender 
{
	InfoViewController_iPad *infoVC = [[InfoViewController_iPad alloc] initWithNibName:@"InfoViewController_iPad" bundle:nil];
	
	[infoVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
	
	[self presentModalViewController:infoVC animated:YES];
}

@end
