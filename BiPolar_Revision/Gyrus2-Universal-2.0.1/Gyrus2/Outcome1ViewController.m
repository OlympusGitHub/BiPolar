//
//  Outcome1ViewController.m
//  Gyrus2
//
//  Created by James Hollender on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Outcome1ViewController.h"
#import "Outcome2ViewController.h"

@implementation Outcome1ViewController

@synthesize segmentedControl;
@synthesize tableView;
@synthesize labelPK;
@synthesize labelOlympus;
@synthesize modelArray;
@synthesize modelArrayOlympus;
@synthesize modelArrayPK;
@synthesize sectionStarts;
@synthesize sectionStartsPK;
@synthesize sectionStartsOlympus;
@synthesize passedArray;
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
	passedArray = [NSMutableArray new];
	
	if ( iPadDevice ) {
		self.segmentedControl.frame = CGRectMake(-384, 0, 4 * 384, 45);
		
		labelPK.frame = CGRectMake(0, labelPK.frame.origin.y, 384, labelPK.frame.size.height);
		labelOlympus.frame = CGRectMake(384, labelOlympus.frame.origin.y, 384, labelOlympus.frame.size.height);
	}
	
	self.segmentedControl.transform = CGAffineTransformMakeScale(1.0, 2.0);
	
	self.navigationItem.prompt = iPadDevice ? @"PK® Technology and Olympus Resection in Saline: Bipolar Clinical Studies" : @"Olympus Clinical Studies";
	
	[self.navigationController setNavigationBarHidden:NO];
	
	[self readOutcomeFile];
	
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
	[self setPassedArray:nil];
    [self setLabelPK:nil];
    [self setLabelOlympus:nil];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		
		cell.backgroundColor = [UIColor clearColor];
		
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iPadDevice ? 768 : 320, 50)];
		imageView.image = [UIImage imageNamed:@"TableViewCellBG.png"];
		imageView.contentMode = UIViewContentModeScaleToFill;
		
		[cell addSubview:imageView];
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 3, self.tableView.frame.size.width - 52, 42)];
		label.tag = 4;
		label.numberOfLines = iPadDevice ? 1 : 2;
		label.font = [UIFont fontWithName:@"Helvetica-Bold" size:iPadDevice ? 26.0 : 18.0];
		label.lineBreakMode = UILineBreakModeWordWrap;
		label.textColor = OLYMPUS_BLUE;
		label.backgroundColor = [UIColor clearColor];
		
		[cell addSubview:label];
		
		UILabel *disclosure = [[UILabel alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 34, 15, 20, 20)];
		disclosure.font = [UIFont boldSystemFontOfSize:20];
		disclosure.textColor = OLYMPUS_BLUE;
		disclosure.backgroundColor = [UIColor clearColor];
		disclosure.text = @"➤";
		
		[cell addSubview:disclosure];
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
	
	gyrus2model = [arrayModel objectAtIndex:[(NSString *)[arrayStarts objectAtIndex:indexPath.row] intValue]];
    
    // Configure the cell...
	UILabel *label = (UILabel *)[cell viewWithTag:4];
	label.text = [NSString stringWithFormat:@"%@", [self stringForTVC:gyrus2model.outcome]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	NSMutableArray *arrayStarts;
	NSMutableArray *arrayModel;
	
	Outcome2ViewController *outcome2VC = [[Outcome2ViewController alloc] initWithNibName:@"Outcome2ViewController" bundle:nil];
	
	switch ( [segmentedControl selectedSegmentIndex] )
	{
		case 1:	// PK
			arrayStarts = sectionStartsPK;
			arrayModel = modelArrayPK;
			outcome2VC.navigationItem.prompt = [NSString stringWithFormat:@"%@ [%@]", iPadDevice ? @"PK® Technology and Olympus Resection in Saline: Bipolar Clinical Studies" : @"Olympus Clinical Studies", @"PK"];
			break;
			
		case 2:	// Olympus
			arrayStarts = sectionStartsOlympus;
			arrayModel = modelArrayOlympus;
			outcome2VC.navigationItem.prompt = [NSString stringWithFormat:@"%@ [%@]", iPadDevice ? @"PK® Technology and Olympus Resection in Saline: Bipolar Clinical Studies" : @"Olympus Clinical Studies", @"Olympus"];
			break;
			
		default: // All
			arrayStarts = sectionStarts;
			arrayModel = modelArray;
			outcome2VC.navigationItem.prompt = [NSString stringWithFormat:@"%@ [%@]", iPadDevice ? @"PK® Technology and Olympus Resection in Saline: Bipolar Clinical Studies" : @"Olympus Clinical Studies", @"PK and/or Olympus"];
			break;
	}
	
	outcome2VC.title = @"Outcome";
	
	[passedArray removeAllObjects];
	
	NSInteger start = [(NSString *)[arrayStarts objectAtIndex:indexPath.row] intValue];
	NSInteger stop;
	
	if ( indexPath.row < [arrayStarts count] - 1 )
		stop = [(NSString *)[arrayStarts objectAtIndex:indexPath.row + 1] intValue];
	else
		stop = [arrayModel count];
	
	for ( int i = start; i < stop; i++ )
		[passedArray addObject:[arrayModel objectAtIndex:i]];
	
	outcome2VC.modelArray = self.passedArray;
	
	[self.navigationController pushViewController:outcome2VC animated:YES];
}

#pragma mark - Segemented Control

- (IBAction)segmentedControlValueChanged:(id)sender 
{
	labelPK.font = [UIFont fontWithName:@"Helvetica" size:20];
	labelOlympus.font = [UIFont fontWithName:@"Helvetica" size:20];
	
	labelPK.backgroundColor = [UIColor clearColor];
	labelOlympus.backgroundColor = [UIColor clearColor];
	
	UIColor *selectedColor = [UIColor colorWithPatternImage:[UIImage imageNamed:iPadDevice ? @"iPadSelected2" : @"iPhoneSelected2"]];
	
	switch ( segmentedControl.selectedSegmentIndex )
	{
		case 1:
			labelPK.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
			labelPK.backgroundColor = selectedColor;
			break;
			
		case 2:
			labelOlympus.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
			labelOlympus.backgroundColor = selectedColor;
			break;
	}
	
	[tableView reloadData];
	
	[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark - read CSV files

#define LBUFSIZ 10000

- (void) readOutcomeFile 
{
	FILE *myfile;
	char line1[LBUFSIZ];
	char line2[LBUFSIZ];
	char line3[LBUFSIZ];	/* Each field in the line */
	char *stptr;
	int idx = 0;
	int fcount = 0;			/* Field Count */	
	int lcount = 0;			/* Line Count */
	
	if ( ! (myfile = fopen([[[NSBundle mainBundle] pathForResource:@"outcome" ofType:@"txt"] UTF8String], "r")) )
	{
		fprintf(stderr, "Could not open \"outcome.txt\" for for reading\n");
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
		
		gyrus2model.listType = OUTCOME;
		
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
						
						[self addOutcomeField:fcount withString:[NSString stringWithFormat:@"%s", line3] toModel:gyrus2model];
						
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
						
						[self addOutcomeField:fcount withString:[NSString stringWithFormat:@"%s", line3] toModel:gyrus2model];
						
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
				
				[self addOutcomeField:fcount withString:[NSString stringWithFormat:@"%s", line3] toModel:gyrus2model];
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
			
			NSString *left = [NSString stringWithFormat:@"%@|%@|%@|%@|%@",
							  gyrus2model.outcome,
							  gyrus2model.procedure,
							  gyrus2model.productLine,
							  gyrus2model.product,
							  gyrus2model.author];
			
			NSString *right = [NSString stringWithFormat:@"%@|%@|%@|%@|%@",
							   g2m.outcome,
							   g2m.procedure,
							   g2m.productLine,
							   g2m.product,
							   g2m.author];
			
			if ( [[left uppercaseString] isEqualToString:[right uppercaseString]] == -1 )
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

- (void) addOutcomeField:(int)fcount withString:(NSString *)line3 toModel:(Gyrus2Model *)gyrus2model
{
//	NSLog(@"addOutcomeField [%d] [%@]", fcount, line3);
	switch ( fcount )
	{
		case 0:
			gyrus2model.outcome = line3;
			break;
			
		case 1:
			gyrus2model.procedure = line3;
			break;
			
		case 2:
			gyrus2model.productLine = line3;
			break;
			
		case 3:
			gyrus2model.product = line3;
			break;
			
		case 4:
			gyrus2model.author = line3;
			break;
			
		case 5:
			gyrus2model.productLine = line3;
			break;
			
		case 6:
			gyrus2model.articleTitle = line3;
			break;
			
		case 7:
			gyrus2model.reference = line3;
			break;
			
		case 8:
			gyrus2model.outcomeOrComments = line3;
			break;
			
		case 9:
			gyrus2model.abstract = line3;
			break;
			
		case 10:
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
		
		if ( ! [[g2mB.outcome capitalizedString] isEqualToString:[g2mA.outcome capitalizedString]] )
			[mySectionStarts addObject:[NSString stringWithFormat:@"%d", i]];
	}
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
	
	[workString replaceOccurrencesOfString:@"?" withString:@"™" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	return (NSString *)workString;
}

@end
