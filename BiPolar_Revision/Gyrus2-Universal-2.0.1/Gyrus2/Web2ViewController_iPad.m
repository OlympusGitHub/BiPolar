//
//  Web2ViewController_iPad.m
//  Gyrus2
//
//  Created by James Hollender on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Web2ViewController_iPad.h"

@interface Web2ViewController_iPad ()

@end

@implementation Web2ViewController_iPad
@synthesize labelTitle;
@synthesize webView;
@synthesize spinner;
@synthesize gyrus2model;

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
    [self setWebView:nil];
    [self setSpinner:nil];
	[self setGyrus2model:nil];
	
	[self setLabelTitle:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if ( UIInterfaceOrientationIsPortrait(interfaceOrientation) )
	{
		self.labelTitle.frame = CGRectMake(labelTitle.frame.origin.x, labelTitle.frame.origin.y, 442, labelTitle.frame.size.height);
	} else {
		self.labelTitle.frame = CGRectMake(labelTitle.frame.origin.x, labelTitle.frame.origin.y, 442 + 256, labelTitle.frame.size.height);
	}
	
	return YES;
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
