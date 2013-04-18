//
//  MainMenuViewController.m
//  Gyrus2
//
//  Created by James Hollender on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController
@synthesize viewOneTime;
@synthesize labelClinicalStudy;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.title = @"Main Menu";
	[self.navigationController setNavigationBarHidden:YES];
	viewOneTime.alpha = 1.0;
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:YES];
	
	[UIView animateWithDuration:0.5 animations:^{
		viewOneTime.alpha = 0.0;
	}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.labelClinicalStudy.text = @"PK® Technology and Olympus\nResection in Saline: Bipolar Clinical Studies";
}

- (void)viewDidUnload
{
	[self setViewOneTime:nil];
	[self setLabelClinicalStudy:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)buttonOutcomesTap:(id)sender 
{
	Outcome1ViewController *outcome1VC = [[Outcome1ViewController alloc] initWithNibName:@"Outcome1ViewController" bundle:[NSBundle mainBundle]];
	outcome1VC.title = @"Outcomes";
	[self.navigationController pushViewController:outcome1VC animated:NO];
}

- (IBAction)buttonProceduresTap:(id)sender 
{
	Procedure1ViewController *procedure1VC = [[Procedure1ViewController alloc] initWithNibName:@"Procedure1ViewController" bundle:[NSBundle mainBundle]];
	procedure1VC.title = @"Procedures";
	[self.navigationController pushViewController:procedure1VC animated:NO];
}

- (IBAction)buttonIndexTap:(id)sender
{
	AuthorsViewController *authorsVC = [[AuthorsViewController alloc] initWithNibName:@"AuthorsViewController" bundle:[NSBundle mainBundle]];
	authorsVC.title = @"Author Index";
	[self.navigationController pushViewController:authorsVC animated:NO];
}

@end
