//
//  RequestViewController.m
//  Gyrus2
//
//  Created by James Hollender on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RequestViewController.h"

@interface RequestViewController ()

@end

@implementation RequestViewController
@synthesize textFieldAttentionTo;
@synthesize textFieldAddress1;
@synthesize textFieldAddress2;
@synthesize textFieldCity;
@synthesize textFieldState;
@synthesize textFieldZip;
@synthesize textFieldCopies;
@synthesize labelAuthor;
@synthesize labelTitle;
@synthesize requestPopoverController;
@synthesize iPadDevice;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#include "KeyboardPrevNext1.h"

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	arrayFields = [[NSArray alloc] initWithObjects:
				   textFieldAttentionTo,
				   textFieldAddress1,
				   textFieldAddress2,
				   textFieldCity,
				   textFieldState,
				   textFieldZip,
				   textFieldCopies,
				   nil];
#include "KeyboardPrevNext2.h"
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	if ( [defaults objectForKey:@"textFieldAttentionTo"] )
		textFieldAttentionTo.text = [defaults stringForKey:@"textFieldAttentionTo"];
	
	if ( [defaults objectForKey:@"textFieldAddress1"] )
		textFieldAddress1.text = [defaults stringForKey:@"textFieldAddress1"];
	
	if ( [defaults objectForKey:@"textFieldAddress2"] )
		textFieldAddress2.text = [defaults stringForKey:@"textFieldAddress2"];
	
	if ( [defaults objectForKey:@"textFieldCity"] )
		textFieldCity.text = [defaults stringForKey:@"textFieldCity"];
	
	if ( [defaults objectForKey:@"textFieldState"] )
		textFieldState.text = [defaults stringForKey:@"textFieldState"];
	
	if ( [defaults objectForKey:@"textFieldZip"] )
		textFieldZip.text = [defaults stringForKey:@"textFieldZip"];
	
	if ( [defaults objectForKey:@"textFieldCopies"] )
		textFieldCopies.text = [defaults stringForKey:@"textFieldCopies"];
	
	if ( [defaults objectForKey:@"textFieldAttentionTo"] )
		textFieldAttentionTo.text = [defaults stringForKey:@"textFieldAttentionTo"];
	
	AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	self.labelAuthor.text = delegate.gyrus2model.author;
	self.labelTitle.text = [NSString stringWithFormat:@"%@\n\n\n\n\n\n", delegate.gyrus2model.articleTitle];
	
	if ( iPadDevice )
	{
		self.view.backgroundColor = [UIColor colorWithRed:12.0/255.0 green:77.0/255.0 blue:162.0/255.0 alpha:1.0];
	}
}

- (void)viewDidUnload
{
	[self setTextFieldAttentionTo:nil];
	[self setTextFieldAddress1:nil];
	[self setTextFieldAddress2:nil];
	[self setTextFieldCity:nil];
	[self setTextFieldState:nil];
	[self setTextFieldZip:nil];
	[self setTextFieldCopies:nil];
    [self setLabelAuthor:nil];
    [self setLabelTitle:nil];
	[self setRequestPopoverController:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if ( iPadDevice )
		return UIInterfaceOrientationIsPortrait(interfaceOrientation);
	else
		return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)buttonCancelTap:(id)sender
{
	[self buttonDoneTap:nil];
	
	if ( ! iPadDevice )
		[self dismissModalViewControllerAnimated:YES];
	else
		[self.requestPopoverController dismissPopoverAnimated:YES];
}

- (IBAction)bujttonCreateEmailTap:(id)sender
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject:textFieldAttentionTo.text forKey:@"textFieldAttentionTo"];
	[defaults setObject:textFieldAddress1.text forKey:@"textFieldAddress1"];
	[defaults setObject:textFieldAddress2.text forKey:@"textFieldAddress2"];
	[defaults setObject:textFieldCity.text forKey:@"textFieldCity"];
	[defaults setObject:textFieldState.text forKey:@"textFieldState"];
	[defaults setObject:textFieldZip.text forKey:@"textFieldZip"];
	[defaults setObject:textFieldCopies.text forKey:@"textFieldCopies"];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"emailRequest" object:nil];
	
	[self buttonCancelTap:nil];
}

@end
