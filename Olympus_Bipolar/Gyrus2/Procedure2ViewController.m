//
//  Procedure2ViewController.m
//  Gyrus2
//
//  Created by James Hollender on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Procedure2ViewController.h"

@implementation Procedure2ViewController

@synthesize tableView;
@synthesize modelArray;
@synthesize iPadDevice;

#define OLYMPUS_BLUE [UIColor colorWithRed:12.0/255.0 green:77.0/255.0 blue:162.0/255.0 alpha:1.0]

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
    if (self) 
	{
        // Custom initialization		
		self.hidesBottomBarWhenPushed = YES;
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
}

- (void)viewDidUnload
{
	[self setTableView:nil];
	[self setModelArray:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	if ( iPadDevice )
		return UIInterfaceOrientationIsPortrait(interfaceOrientation);
	else
		return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	Gyrus2Model *g2m = [modelArray objectAtIndex:0];
	
	return [self stringForTVC:g2m.procedure];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	Gyrus2Model *g2m = (Gyrus2Model *)[modelArray objectAtIndex:0];
	
	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 40)];
	
	headerView.backgroundColor = [UIColor colorWithRed:255.0 / 255.0 green:189.0 / 255.0 blue:48.0 / 255.0 alpha:1.0];
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, headerView.frame.size.width - 24, 44)];
	label.numberOfLines = iPadDevice ? 1 : 2;
	label.shadowColor = [UIColor clearColor];
	label.shadowOffset = CGSizeMake(1, 1);
	label.lineBreakMode = UILineBreakModeWordWrap;
	label.textColor = OLYMPUS_BLUE;
	label.backgroundColor = [UIColor clearColor];
	label.text = [NSString stringWithFormat:@"%@", [self stringForTVC:g2m.procedure]];

	if ( iPadDevice )
	{
		if ( [g2m.procedure hasPrefix:@"Urethral Strictures"] )
			label.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0];
		else
			label.font = [UIFont fontWithName:@"Helvetica-Bold" size:24.0];
	}
	else
	{
		if ( [g2m.procedure hasPrefix:@"Urethral Strictures"] )
			label.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
		else
			label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0];
	}

	[headerView addSubview:label];
	
	return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 44.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
	return [modelArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		
		cell.backgroundColor = [UIColor clearColor];
		
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iPadDevice ? 768 : 320, 70)];
		imageView.image = [UIImage imageNamed:@"TableViewCellBG.png"];
		imageView.contentMode = UIViewContentModeScaleToFill;
		
		[cell addSubview:imageView];
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 5, self.tableView.frame.size.width - 18, 30)];
		label.tag = 4;
		label.numberOfLines = iPadDevice ? 1 : 2;
		label.font = [UIFont fontWithName:@"Helvetica-Bold" size:iPadDevice ? 22.0 : 13.0];
		label.textColor = OLYMPUS_BLUE;
		label.backgroundColor = [UIColor clearColor];
		
		if ( iPadDevice )
		{
			label.minimumFontSize = 16.0;
			label.adjustsFontSizeToFitWidth = YES;
		}
		else
		{
			label.lineBreakMode = UILineBreakModeWordWrap;
		}
		
		[cell addSubview:label];
		
		if ( iPadDevice )
		{
			UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(12, 35, 550, 30)];
			label2.tag = 5;
			label2.numberOfLines = 1;
			label2.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0];
			label2.lineBreakMode = UILineBreakModeWordWrap;
			label2.textColor = OLYMPUS_BLUE;
			label2.backgroundColor = [UIColor clearColor];
			
			[cell addSubview:label2];
			
			UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(570, 35, 200, 30)];
			label3.tag = 6;
			label3.numberOfLines = 1;
			label3.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0];
			label3.lineBreakMode = UILineBreakModeWordWrap;
			label3.textColor = OLYMPUS_BLUE;
			label3.backgroundColor = [UIColor clearColor];
			
			[cell addSubview:label3];
		}
		else
		{
			UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(12, 35, cell.frame.size.width - 18, 30)];
			label4.tag = 7;
			label4.numberOfLines = 2;
			label4.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0];
			label4.lineBreakMode = UILineBreakModeWordWrap;
			label4.textColor = OLYMPUS_BLUE;
			label4.backgroundColor = [UIColor clearColor];
			
			[cell addSubview:label4];
		}
    }
		
	Gyrus2Model *gyrus2model = [modelArray objectAtIndex:indexPath.row];
    
    // Configure the cell...
	UILabel *label = (UILabel *)[cell viewWithTag:4];
	label.text = [NSString stringWithFormat:@"Outcome %d: %@\n\n",indexPath.row + 1, [self stringForTVC:gyrus2model.outcome]];
	
	if ( iPadDevice )
	{
		UILabel *label2 = (UILabel *)[cell viewWithTag:5];
		label2.text = [NSString stringWithFormat:@"Product: [%@] %@", gyrus2model.productLine, [self stringForProduct:gyrus2model.product]];
		
		UILabel *label3 = (UILabel *)[cell viewWithTag:6];
		label3.text = [NSString stringWithFormat:@"Author: %@", gyrus2model.author];
	}
	else
	{
		UILabel *label4 = (UILabel *)[cell viewWithTag:7];
		label4.text = [NSString stringWithFormat:@"Product: [%@] %@\nAuthor: %@", gyrus2model.productLine, [self stringForProduct:gyrus2model.product], gyrus2model.author];
	}
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	delegate.gyrus2model = (Gyrus2Model *)[modelArray objectAtIndex:indexPath.row];
	delegate.stringTitle = @"Procedure";
	delegate.fromAuthorsPage = NO;
	
	WebViewController *webVC = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
	webVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	[self presentModalViewController:webVC animated:YES];
}

- (NSString *) stringForTVC:(NSString *)string
{
	NSMutableString *workString = [[NSMutableString alloc] initWithFormat:@"%@", string];
	
	[workString replaceOccurrencesOfString:@"<BR>" withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	return (NSString *)workString;
}

- (NSString *) stringForProduct:(NSString *)string
{
	NSMutableString *workString = [[NSMutableString alloc] initWithFormat:@"%@", string];
	
	[workString replaceOccurrencesOfString:@"ô" withString:@"™" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	return (NSString *)workString;
}

@end
