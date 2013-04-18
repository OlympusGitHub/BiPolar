//
//  Web2ViewController.m
//  Gyrus2
//
//  Created by James Hollender on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Web2ViewController.h"

@implementation Web2ViewController
@synthesize labelTitle;
@synthesize buttonBack;
@synthesize buttonForward;
@synthesize buttonReload;
@synthesize buttonStop;
@synthesize webView;
@synthesize spinner;
@synthesize gyrus2model;
@synthesize iPadDevice;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		iPadDevice = delegate.iPadDevice;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	switch ( self.gyrus2model.listType )
	{
		case OUTCOME:
			self.labelTitle.text = [NSString stringWithFormat:@"Outcome: %@", gyrus2model.outcome];
			break;
			
		case PROCEDURE:
			self.labelTitle.text = [NSString stringWithFormat:@"Procedure: %@", gyrus2model.procedure];
			break;
			
		case AUTHOR:
			self.labelTitle.text = [NSString stringWithFormat:@"Author: %@", gyrus2model.author];
			break;
	}
	
//	NSLog(@"URL: '%@'", self.gyrus2model.hyperlink);	// jbh2
	
	[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.gyrus2model.hyperlink]]]; 
}

- (void)viewDidUnload
{
    [self setLabelTitle:nil];
    [self setButtonBack:nil];
    [self setButtonForward:nil];
    [self setButtonReload:nil];
    [self setButtonStop:nil];
	[self setGyrus2model:nil];
	[self setWebView:nil];
	[self setSpinner:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	if ( iPadDevice )
		return UIInterfaceOrientationIsPortrait(interfaceOrientation);
	else
		return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)buttonDoneTap:(id)sender 
{
	[self dismissModalViewControllerAnimated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{    
	[spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView 
{    
	[spinner stopAnimating];
}

@end
