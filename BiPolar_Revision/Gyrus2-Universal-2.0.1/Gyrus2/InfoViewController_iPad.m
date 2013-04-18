//
//  InfoViewController_iPad.m
//  Gyrus2
//
//  Created by James Hollender on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InfoViewController_iPad.h"

@interface InfoViewController_iPad ()

@end

@implementation InfoViewController_iPad
@synthesize labelVersion;

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
	
	NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
	
	self.labelVersion.text = [NSString stringWithFormat:@"Version %@", [infoDictionary objectForKey:@"CFBundleVersion"]];
}

- (void)viewDidUnload
{
	[self setLabelVersion:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)doneButtonTap:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

@end
