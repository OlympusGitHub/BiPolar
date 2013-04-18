//
//  AuthorsViewController.m
//  Gyrus2
//
//  Created by James Hollender on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AuthorsViewController.h"

@implementation AuthorsViewController
@synthesize segmentedControl;
@synthesize tableView;
@synthesize labelAll;
@synthesize labelOlympus;
@synthesize labelPK;
@synthesize modelArray;
@synthesize modelArrayOlympus;
@synthesize modelArrayPK;
@synthesize sectionStarts;
@synthesize sectionStartsPK;
@synthesize sectionStartsOlympus;
@synthesize iPadDevice;

#define OLYMPUS_BLUE [UIColor colorWithRed:12.0/255.0 green:77.0/255.0 blue:162.0/255.0 alpha:1.0]

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
	
	modelArray = [NSMutableArray new];
	modelArrayOlympus = [NSMutableArray new];
	modelArrayPK = [NSMutableArray new];
	sectionStarts = [NSMutableArray new];
	sectionStartsPK = [NSMutableArray new];
	sectionStartsOlympus = [NSMutableArray new];
	
	self.navigationItem.prompt = iPadDevice ? @"PK® Technology and Olympus Resection in Saline: Bipolar Clinical Studies" : @"Olympus Clinical Studies";
	
	if ( iPadDevice ) {
		self.segmentedControl.frame = CGRectMake(-256, 0, 5 * 256, 45);

		labelPK.frame = CGRectMake(0, labelPK.frame.origin.y, 256, labelPK.frame.size.height);
		labelOlympus.frame = CGRectMake(256, labelOlympus.frame.origin.y, 256, labelOlympus.frame.size.height);
		labelAll.frame = CGRectMake(512, labelAll.frame.origin.y, 256, labelAll.frame.size.height);
	}
	
	self.segmentedControl.transform = CGAffineTransformMakeScale(1.0, 2.0);
	
	[self.navigationController setNavigationBarHidden:NO];
	
	[self readIndexFile];
	
	[self segmentedControlValueChanged:segmentedControl];
}

- (void)viewDidUnload
{
    [self setSegmentedControl:nil];
    [self setTableView:nil];
	[self setModelArray:nil];
	[self setModelArrayOlympus:nil];
	[self setModelArrayPK:nil];
	[self setSectionStarts:nil];
	[self setSectionStartsPK:nil];
	[self setSectionStartsOlympus:nil];
	[self setLabelAll:nil];
	[self setLabelOlympus:nil];
	[self setLabelPK:nil];
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
	switch ( [segmentedControl selectedSegmentIndex] )
	{
		case 1:	// PK
			return [sectionStartsPK count];
			break;
			
		case 2:	// Olympus
			return [sectionStartsOlympus count];
			break;
			
		default: // All
			return [sectionStarts count];
			break;
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	Gyrus2Model *g2m;
	
	switch ( [segmentedControl selectedSegmentIndex] )
	{
		case 1:	// PK
			g2m = [modelArrayPK objectAtIndex:[[sectionStartsPK objectAtIndex:section] intValue]];
			break;
			
		case 2:	// Olympus
			g2m = [modelArrayOlympus objectAtIndex:[[sectionStartsOlympus objectAtIndex:section] intValue]];
			break;
			
		default: // All
			g2m = [modelArray objectAtIndex:[[sectionStarts objectAtIndex:section] intValue]];
			break;
	}
	
	return g2m.author;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	Gyrus2Model *g2m;
	
	switch ( [segmentedControl selectedSegmentIndex] )
	{
		case 1:	// PK
			g2m = [modelArrayPK objectAtIndex:[[sectionStartsPK objectAtIndex:section] intValue]];
			break;
			
		case 2:	// Olympus
			g2m = [modelArrayOlympus objectAtIndex:[[sectionStartsOlympus objectAtIndex:section] intValue]];
			break;
			
		default: // All
			g2m = [modelArray objectAtIndex:[[sectionStarts objectAtIndex:section] intValue]];
			break;
	}
	
	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 40)];
	
	headerView.backgroundColor = [UIColor clearColor];
	
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iPadDevice ? 768 : 320, 34)];
	imageView.image = [UIImage imageNamed:@"Header_gradient.jpg"];
	imageView.contentMode = UIViewContentModeScaleToFill;
	
	[headerView addSubview:imageView];
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, headerView.frame.size.width - 62, 34)];
	label.font = [UIFont fontWithName:@"Helvetica-Bold" size:iPadDevice ? 24.0 : 18.0];
	label.shadowColor = [UIColor clearColor];
	label.shadowOffset = CGSizeMake(1, 1);
	label.textColor = [UIColor colorWithRed:255.0 / 255.0 green:189.0 / 255.0 blue:48.0 / 255.0 alpha:1.0];
	label.backgroundColor = [UIColor clearColor];
	label.text = [NSString stringWithFormat:@"%@", [self stringForTVC:g2m.author]];
	
	[headerView addSubview:label];
	
	UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 34, self.tableView.frame.size.width, 1)];
	
	lineView.backgroundColor = [UIColor colorWithRed:255.0 / 255.0 green:189.0 / 255.0 blue:48.0 / 255.0 alpha:1.0];
	
	[headerView addSubview:lineView];
	
	return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 34.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
	NSMutableArray *arrayStarts;
	NSMutableArray *arrayModel;
	
	switch ( [segmentedControl selectedSegmentIndex] )
	{
		case 1:	// PK
			arrayStarts = sectionStartsPK;
			arrayModel = modelArrayPK;
			break;
			
		case 2:	// Olympus
			arrayStarts = sectionStartsOlympus;
			arrayModel = modelArrayOlympus;
			break;
			
		default: // All
			arrayStarts = sectionStarts;
			arrayModel = modelArray;
			break;
	}
	
	if ( section == [arrayStarts count] - 1 )
		return [arrayModel count] - [(NSString *)[arrayStarts objectAtIndex:section] intValue];
	else
		return [(NSString *)[arrayStarts objectAtIndex:section + 1] intValue] - [(NSString *)[arrayStarts objectAtIndex:section] intValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ( [segmentedControl selectedSegmentIndex] == 3 )
		return 85.0;
	else
		return 70.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier;
	
	if ( [segmentedControl selectedSegmentIndex] != 3 )
		CellIdentifier = @"Cell";
	else
		CellIdentifier = @"Cell2";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		
		cell.backgroundColor = [UIColor clearColor];
		
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iPadDevice ? 768 : 320, [segmentedControl selectedSegmentIndex] == 3 ? 85 : 70)];
		imageView.image = [UIImage imageNamed:@"TableViewCellBG.png"];
		imageView.contentMode = UIViewContentModeScaleToFill;
		
		[cell addSubview:imageView];
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, iPadDevice ? 3 : 5, self.tableView.frame.size.width - 24, 60)];
		label.tag = 4;
		label.numberOfLines = iPadDevice ? 2 : 4;
		label.font = [UIFont fontWithName:@"Helvetica-Bold" size:iPadDevice ? 18.0 : 12.0];
		label.lineBreakMode = UILineBreakModeWordWrap;
		label.textColor = OLYMPUS_BLUE;
		label.backgroundColor = [UIColor clearColor];
		
		[cell addSubview:label];
		
		if ( [segmentedControl selectedSegmentIndex] == 3 )
		{
			UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(12, iPadDevice ? 60 : 65, cell.frame.size.width - 18, iPadDevice ? 18 : 15)];
			label2.tag = 5;
			label2.numberOfLines = 1;
			label2.font = [UIFont fontWithName:@"Helvetica-Bold" size:iPadDevice ? 14.0 : 10.0];
			label2.lineBreakMode = UILineBreakModeWordWrap;
			label2.textColor = OLYMPUS_BLUE;
			label2.backgroundColor = [UIColor clearColor];
			
			[cell addSubview:label2];
		}
    }
	
	Gyrus2Model *gyrus2model;
	NSMutableArray *arrayStarts;
	NSMutableArray *arrayModel;
	
	switch ( [segmentedControl selectedSegmentIndex] )
	{
		case 1:	// PK
			arrayStarts = sectionStartsPK;
			arrayModel = modelArrayPK;
			break;
			
		case 2:	// Olympus
			arrayStarts = sectionStartsOlympus;
			arrayModel = modelArrayOlympus;
			break;
			
		default: // All
			arrayStarts = sectionStarts;
			arrayModel = modelArray;
			break;
	}
	
	gyrus2model = [arrayModel objectAtIndex:[(NSString *)[arrayStarts objectAtIndex:indexPath.section] intValue] + indexPath.row];
    
    // Configure the cell...
	UILabel *label = (UILabel *)[cell viewWithTag:4];
	label.text = [NSString stringWithFormat:@"%@\n\n\n", [self stringForTVC:gyrus2model.articleTitle]];
	
	if ( [segmentedControl selectedSegmentIndex] == 3 )
	{
		UILabel *label2 = (UILabel *)[cell viewWithTag:5];
		label2.text = [NSString stringWithFormat:@"Product Line: %@", gyrus2model.productLine];
	}
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	NSMutableArray *arrayStarts;
	NSMutableArray *arrayModel;
	
	switch ( [segmentedControl selectedSegmentIndex] )
	{
		case 1:	// PK
			arrayStarts = sectionStartsPK;
			arrayModel = modelArrayPK;
			break;
			
		case 2:	// Olympus
			arrayStarts = sectionStartsOlympus;
			arrayModel = modelArrayOlympus;
			break;
			
		default: // All
			arrayStarts = sectionStarts;
			arrayModel = modelArray;
			break;
	}
	
	AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	delegate.fromAuthorsPage = YES;
	delegate.gyrus2model = (Gyrus2Model *)[arrayModel objectAtIndex:indexPath.row + [(NSString *)[arrayStarts objectAtIndex:indexPath.section] intValue]];
	delegate.fromAuthorsPage = YES;
	
	NSString *authorTitle = delegate.gyrus2model.author;
	
	if ( ! iPadDevice )
	{
		CGSize size1 = [@"Fagerstrom" sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:20.0]];
		CGSize size2 = [authorTitle sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:20.0]];
		
		if ( size2.width > size1.width )
			authorTitle = [NSString stringWithFormat:@"%@    ", authorTitle];
	}
	
	delegate.stringTitle = authorTitle;
	
	WebViewController *webVC = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
	webVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	[self presentModalViewController:webVC animated:YES];
}

#pragma mark - Segemented Control

- (IBAction)segmentedControlValueChanged:(id)sender 
{
	labelPK.font = [UIFont fontWithName:@"Helvetica" size:20];
	labelOlympus.font = [UIFont fontWithName:@"Helvetica" size:20];
	labelAll.font = [UIFont fontWithName:@"Helvetica" size:20];
	
	labelPK.backgroundColor = [UIColor clearColor];
	labelOlympus.backgroundColor = [UIColor clearColor];
	labelAll.backgroundColor = [UIColor clearColor];
	
	UIColor *selectedColor = [UIColor colorWithPatternImage:[UIImage imageNamed:iPadDevice ? @"iPadSelected3" : @"iPhoneSelected3"]];
	
	switch ( segmentedControl.selectedSegmentIndex )
	{
		case 1:
			labelPK.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
			labelPK.backgroundColor = selectedColor;
			break;
			
		case 2:
			labelOlympus.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
			labelOlympus.backgroundColor = selectedColor;
			break;
			
		case 3:
			labelAll.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
			labelAll.backgroundColor = selectedColor;
			break;
	}
	
	[tableView reloadData];
	
	[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark - read CSV files

#define LBUFSIZ 5000

- (void) readIndexFile 
{
	FILE *myfile;
	char line1[LBUFSIZ];
	char line2[LBUFSIZ];
	char line3[LBUFSIZ];	/* Each field in the line */
	char *stptr;
	int idx = 0;
	int fcount = 0;			/* Field Count */	
	int lcount = 0;			/* Line Count */
	
	if ( ! (myfile = fopen([[[NSBundle mainBundle] pathForResource:@"index_by_author" ofType:@"txt"] UTF8String], "r")) )
	{
		fprintf(stderr, "Could not open \"index_by_author.txt\" for for reading\n");
		exit(EXIT_FAILURE);
	}
	
	// Skip header line
	fgets(line1, sizeof line1, myfile);
	
	// Get a line from file
	while (fgets(line1, sizeof line1, myfile) != NULL)
	{
		fcount = 0;
		strcpy(line2, line1);
		stptr = line2;
		
		Gyrus2Model *gyrus2model = [Gyrus2Model new];
		
		gyrus2model.listType = AUTHOR;
		
		// printf("Line %d:\n", lcount);
		
		// start going character by character through the line
		while ( *stptr != '\0' )
		{ 
			// If field begins with "
			if ( *stptr == '"' )
			{ 
				int flag = 0;
				idx = 0;
				
				while ( flag == 0 )
				{ 
					stptr++;
					
					// Find corresponding closing "
					while ( *stptr != '"' )
					{ 
						line3[idx] = *stptr;
						idx++;
						stptr++;
					}
					
					stptr++;
					
					if ( *stptr != '\0' && *stptr == ',' )
					{ 
						
						line3[idx] = '\0';
						
						if ( fcount == 1 && strlen(line3) == 0 ) 
							goto Done;
						
						// printf("a - field %d = %s\n", fcount, line3);
						
						[self addIndexField:fcount withString:[NSString stringWithFormat:@"%s", line3] toModel:gyrus2model];
						
						flag = 1;
					}
					else if ( *stptr != '\0' && *stptr == '"' )
					{ 
						line3[idx] = *stptr;
						idx++;
					}
					else
					{
						
						line3[idx] = '\0';
						
						if ( fcount == 1 && strlen(line3) == 0 ) 
							goto Done;
						
						// printf("b - field %d = %s\n", fcount, line3);
						
						[self addIndexField:fcount withString:[NSString stringWithFormat:@"%s", line3] toModel:gyrus2model];
						
						flag = 1;
					}
				} 
			}
			else
			{ 
				idx = 0;
				
				while ( *stptr != '\0' && *stptr != ',' )
				{ 
					line3[idx] = *stptr;
					idx++;
					stptr++;
				}
				
				line3[idx] = '\0';
				
				if ( fcount == 1 && strlen(line3) == 0 ) 
					goto Done;
				
				// printf("c - field %d = %s\n", fcount, line3);
				
				[self addIndexField:fcount withString:[NSString stringWithFormat:@"%s", line3] toModel:gyrus2model];
			}
			
			if ( *stptr != '\0' && *stptr == ',' )
				stptr++;
			
			strcpy(line2, stptr);
			stptr = line2;
			
			fcount++;
		}
		
		int i;
		
		for ( i = 0; i < [modelArray count]; i++ )
		{
			Gyrus2Model *g2m = [modelArray objectAtIndex:i];
			
			if ( [[gyrus2model.author uppercaseString] isEqualToString:[g2m.author uppercaseString]] == -1 )
				break;
		}
		
		if ( i == [modelArray count] )
			[self.modelArray addObject:gyrus2model];
		else
			[self.modelArray insertObject:gyrus2model atIndex:i];
		
		lcount++;
	}
	
Done:
	fclose(myfile);
	
	for ( int i = 0; i < [modelArray count]; i++ )
	{
		Gyrus2Model *g2m = [modelArray objectAtIndex:i];
		
		if ( [g2m.productLine isEqualToString:@"PK"] )
			[modelArrayPK addObject:[modelArray objectAtIndex:i]];
		else
			[modelArrayOlympus addObject:[modelArray objectAtIndex:i]];
	}
	
	[self createSectionStarts:sectionStarts fromModelArray:modelArray];
	[self createSectionStarts:sectionStartsPK fromModelArray:modelArrayPK];
	[self createSectionStarts:sectionStartsOlympus fromModelArray:modelArrayOlympus];
}

- (void) addIndexField:(int)fcount withString:(NSString *)line3 toModel:(Gyrus2Model *)gyrus2model
{
//	NSLog(@"addIndexField [%d] [%@]", fcount, line3);
	switch ( fcount )
	{
		case 0:
			gyrus2model.author = line3;
			break;
			
		case 1:
			gyrus2model.articleTitle = line3;
			break;
			
		case 2:
			gyrus2model.productLine = line3;
			break;
			
		case 3:
			gyrus2model.articleTitle = line3;
			break;
			
		case 4:
			gyrus2model.reference = line3;
			break;
			
		case 5:
			gyrus2model.outcomeOrComments = line3;
			break;
			
		case 6:
			gyrus2model.abstract = line3;
			break;
			
		case 7:
			gyrus2model.hyperlink = line3;
			break;
	}
}

- (void) createSectionStarts:(NSMutableArray *)mySectionStarts fromModelArray:(NSMutableArray *)myModelArray
{
	[mySectionStarts addObject:@"0"];
	
	for ( int i = 1; i < [myModelArray count]; i++ )
	{
		Gyrus2Model *g2mA = [myModelArray objectAtIndex:i - 1];
		Gyrus2Model *g2mB = [myModelArray objectAtIndex:i];
		
		if ( ! [[g2mB.author capitalizedString] isEqualToString:[g2mA.author capitalizedString]] )
			[mySectionStarts addObject:[NSString stringWithFormat:@"%d", i]];
	}
}

- (NSString *) stringForTVC:(NSString *)string
{
	NSMutableString *workString = [[NSMutableString alloc] initWithFormat:@"%@", string];
	
	[workString replaceOccurrencesOfString:@"<BR>" withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	return (NSString *)workString;
}

@end
