//
//  WebViewController.m
//  Gyrus2
//
//  Created by James Hollender on 2/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController
@synthesize labelTitle;
@synthesize gyrus2model;
@synthesize webView;
@synthesize flexibleSpace;
@synthesize requestPopoverController;
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
	
	AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	self.gyrus2model = delegate.gyrus2model;
	self.labelTitle.text = delegate.stringTitle;
	fromAuthorsPage = delegate.fromAuthorsPage;
	
	if ( fromAuthorsPage )
	{
		listType = AUTHOR;
	}
	else
	{		
		if ( [delegate.stringTitle isEqualToString:@"Outcome"] )
			listType = OUTCOME;
		else
			listType = PROCEDURE;
	}
	
	webView.opaque = NO;
	webView.backgroundColor = UIColor.clearColor;
	for (UIView* view in webView.subviews) {
		view.backgroundColor = UIColor.clearColor;
	}
	
	[self createAndDisplayHTML];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emailRequest:) name:@"emailRequest" object:nil];
}

- (void)viewDidUnload
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
    [self setLabelTitle:nil];
	[self setGyrus2model:nil];
	[self setWebView:nil];
	
	[self setFlexibleSpace:nil];
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

- (IBAction)buttonMoreTap:(id)sender 
{
	if ( iPadDevice )
	{
		Web2ViewController_iPad *web2VC = [[Web2ViewController_iPad alloc] initWithNibName:@"Web2ViewController_iPad" bundle:nil];
		
		web2VC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		web2VC.gyrus2model = self.gyrus2model;
		
		[self presentModalViewController:web2VC animated:YES];
	}
	else
	{
		Web2ViewController *web2VC = [[Web2ViewController alloc] initWithNibName:@"Web2ViewController" bundle:nil];
		
		web2VC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		web2VC.gyrus2model = self.gyrus2model;
		
		[self presentModalViewController:web2VC animated:YES];
	}
}

- (void)createAndDisplayHTML
{
	FILE *fp;
	NSString *documentsDirectory;
	NSString *htmlFile;
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	documentsDirectory = [paths objectAtIndex:0];
	
	// Generate HTML file name based on specific sculpture
	htmlFile = [NSString stringWithFormat:@"%@/index.html", documentsDirectory];
	
	// open for writing binary
	if ((fp = fopen([htmlFile UTF8String], "wb")) == NULL)
	{
		NSLog(@"Unable to open HTML file for writing");
		return;
	}
	
	fprintf(fp, "<HTML>\n");
	
	fprintf(fp, "<HEAD>\n");
	fprintf(fp, "<style type=\"text/css\">\n");
	fprintf(fp, "a:link { COLOR: #FFF; }\n");
	fprintf(fp, "a:visited { COLOR: #FFF; }\n");
	fprintf(fp, "a:hover { COLOR: #FFF; }\n");
	fprintf(fp, "a:active { COLOR: #FFF; }\n");
	fprintf(fp, ".width { max-width:316px; }\n");
	fprintf(fp, "body {font-family: \"Helvetica\"; font-size: 25;}\n");
	fprintf(fp, "</style>\n");
	fprintf(fp, "<HEAD>\n");
	
	fprintf(fp, "<BODY leftmargin=\"10px\" topmargin=\"10px\" marginwidth=\"20px\" marginheight=\"10px\"");
//	fprintf(fp, " style=\"background-color: transparent\"><FONT COLOR=\"white\">\n");
	fprintf(fp, " style=\"background-color: buff\"><FONT COLOR=\"darkblue\">\n");
	
	if ( listType != AUTHOR )
	{
		fprintf(fp, "<BR>\n");
		
		if ( listType == OUTCOME )
		{
			fprintf(fp, "<H1><CENTER>Outcome: %s</CENTER></H1>", [[self stringForGeneral:gyrus2model.outcome] UTF8String]);
			fprintf(fp, "<H2><CENTER>Procedure: %s</CENTER></H2>", [gyrus2model.procedure UTF8String]);
		}
		else
		{
			fprintf(fp, "<H1><CENTER>Procedure: %s</CENTER></H1>", [[self stringForGeneral:gyrus2model.procedure] UTF8String]);
			fprintf(fp, "<H2><CENTER>Outcome: %s</CENTER></H2>", [gyrus2model.outcome UTF8String]);
		}
		
		fprintf(fp, "<H2><CENTER>Product Line: %s</CENTER></H2>", [[self stringForGeneral:gyrus2model.productLine] UTF8String]);
		fprintf(fp, "<H2><CENTER>Product: %s</CENTER></H2>", [[self stringForProduct:gyrus2model.product] UTF8String]);
		fprintf(fp, "<H2><CENTER>Author: %s</CENTER></H2>", [gyrus2model.author UTF8String]);
	}
	
	if ( listType == AUTHOR )
		fprintf(fp, "<BR>\n");
	
	fprintf(fp, "<H1><CENTER>%s</CENTER></H1>", [[self stringForAbstract:gyrus2model.articleTitle] UTF8String]);

	if ( listType == AUTHOR )
	{
		fprintf(fp, "<H3><CENTER>Author: %s</CENTER></H3>", [gyrus2model.author UTF8String]);
		fprintf(fp, "<H3><CENTER>Product Line: %s</CENTER></H3>", [[self stringForGeneral:gyrus2model.productLine] UTF8String]);
	}
	
	fprintf(fp, "<FONT SIZE=+3><CENTER><B>Reference</B></CENTER></FONT>");
	fprintf(fp, "<FONT SIZE=+2><CENTER><B>%s</B></CENTER></FONT>", [[self stringForGeneral:gyrus2model.reference] UTF8String]);
	
	fprintf(fp, "<FONT COLOR=\"darkgold\">");
	
	fprintf(fp, "<H2><CENTER>Outcome / Comments</CENTER></H2>");
	fprintf(fp, "<FONT SIZE=+3><CENTER><B>%s</B><BR><BR></CENTER></FONT>", [[self stringForOutcome:gyrus2model.outcomeOrComments] UTF8String]);
	
	fprintf(fp, "</FONT>");
	
	if ( ! [gyrus2model.abstract isEqualToString:@""] )
	{
		fprintf(fp, "<FONT SIZE=+3><CENTER><B>Abstract</B></CENTER></FONT>");
		
		NSString *abstract = [self stringForAbstract:gyrus2model.abstract];
		
		while ( [abstract hasPrefix:@" "] ) {
			abstract = [abstract substringFromIndex:1];
		}
		
		if ( [abstract hasPrefix:@"<BR><BR>"] ) {
			abstract = [abstract substringFromIndex:4];
		}
		
		if ( ! [abstract hasPrefix:@"<BR>"] ) {
			abstract = [NSString stringWithFormat:@"<BR>%@", abstract];
		}
		
		fprintf(fp, "<FONT SIZE=+2>%s</FONT><BR><BR>", [abstract UTF8String]);
	}
	
	fprintf(fp, "<BR><CENTER><A HREF=\"jbh:requestHardCopy\"><IMG SRC=\"%s/RequestHardCopy.png\" /></A></CENTER><BR><BR></FONT>\n", [[[NSBundle mainBundle] resourcePath] UTF8String]);
	
	fprintf(fp, "</BODY>\n");
	fprintf(fp, "</HTML>\n");
	
	fflush(fp);
	fclose(fp);
	
//	NSLog(@"htmlFile: '%@'", htmlFile);	// jbh2

	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: htmlFile]]]; 
}

- (NSString *) stringForProduct:(NSString *)string
{
	NSMutableString *workString = [[NSMutableString alloc] initWithFormat:@"%@", string];
	
	[workString replaceOccurrencesOfString:@"ô" withString:@"&trade;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	return (NSString *)workString;
}

- (NSString *) stringForGeneral:(NSString *)string
{
	NSMutableString *workString = [[NSMutableString alloc] initWithFormat:@"%@", string];
	
	[workString replaceOccurrencesOfString:@"ñ" withString:@"&ndash;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"ô" withString:@"&trade;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"±" withString:@"&plusmn;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"ì" withString:@"&ldquo;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"î" withString:@"&rdquo;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"Æ" withString:@"&reg;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"í" withString:@"&rsquo;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"<BR><BR>" withString:@"<BR>" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	return (NSString *)workString;
}

- (NSString *) stringForOutcome:(NSString *)string
{
	NSMutableString *workString = [[NSMutableString alloc] initWithFormat:@"%@", string];
	
	[workString replaceOccurrencesOfString:@"ñ" withString:@"&ndash;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"ô" withString:@"&trade;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"±" withString:@"&plusmn;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"ì" withString:@"&ldquo;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"î" withString:@"&rdquo;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"Æ" withString:@"&reg;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"í" withString:@"&rsquo;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"<BR>" withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	return (NSString *)workString;
}

- (NSString *) stringForAbstract:(NSString *)string
{
	int oldLength;
	int newLength;
	
	NSMutableString *workString = [[NSMutableString alloc] initWithFormat:@"%@", string];
	
	if ( [string hasPrefix:@"Abstract"] || [string hasPrefix:@"ABSTRACT"] ) {
		[workString replaceOccurrencesOfString:@"Abstract" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	}
	
	[workString replaceOccurrencesOfString:@"<BR>" withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"BACKGROUND:" withString:@"<BR><BR><B>BACKGROUND:</B>" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"INTRODUCTION:" withString:@"<BR><BR><B>INTRODUCTION:</B>" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	oldLength = workString.length;
	
	[workString replaceOccurrencesOfString:@"INTRODUCTION AND OBJECTIVES:" withString:@"<BR><BR><B>INTRODUCTION AND OBJECTIVES:</B>" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"INTRODUCTION AND OBJECTIVE:" withString:@"<BR><BR><B>INTRODUCTION AND OBJECTIVE:</B>" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	newLength = workString.length;
	
	if ( oldLength == newLength ) {
		[workString replaceOccurrencesOfString:@"OBJECTIVES:" withString:@"<BR><BR><B>OBJECTIVES:</B>" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
		
		[workString replaceOccurrencesOfString:@"OBJECTIVE:" withString:@"<BR><BR><B>OBJECTIVE:</B>" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	}
	
	oldLength = workString.length;
	
	[workString replaceOccurrencesOfString:@"MATERIALS AND METHODS:" withString:@"<BR><BR><B>MATERIALS AND METHODS:</B>" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"MATERIAL AND METHODS:" withString:@"<BR><BR><B>MATERIAL AND METHODS:</B>" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"MATERIAL AND METHOD:" withString:@"<BR><BR><B>MATERIAL AND METHOD:</B>" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"PATIENTS AND METHODS:" withString:@"<BR><BR><B>PATIENTS AND METHODS:</B>" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"PATIENT AND METHODS:" withString:@"<BR><BR><B>PATIENT AND METHODS:</B>" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"PATIENT AND METHOD:" withString:@"<BR><BR><B>PATIENT AND METHOD:</B>" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	newLength = workString.length;
	
	if ( oldLength == newLength ) {
		[workString replaceOccurrencesOfString:@"METHODS:" withString:@"<BR><BR><B>METHODS:</B>" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
		
		[workString replaceOccurrencesOfString:@"METHOD:" withString:@"<BR><BR><B>METHOD:</B>" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	}
	
	[workString replaceOccurrencesOfString:@"RESULTS:" withString:@"<BR><BR><B>RESULTS:</B>" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"RESULT:" withString:@"<BR><BR><B>RESULT:</B>" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	oldLength = workString.length;
	
	[workString replaceOccurrencesOfString:@"BACKGROUND AND PURPOSE:" withString:@"<BR><BR><B>BACKGROUND AND PURPOSE:</B>" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	newLength = workString.length;
	
	if ( oldLength == newLength ) {
		[workString replaceOccurrencesOfString:@"PURPOSE:" withString:@"<BR><BR><B>PURPOSE:</B>" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	}
	
	[workString replaceOccurrencesOfString:@"CONCLUSIONS:" withString:@"<BR><BR><B>CONCLUSIONS:</B>" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"CONCLUSION:" withString:@"<BR><BR><B>CONCLUSION:</B>" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"AIM:" withString:@"<BR><BR><B>AIM:</B>" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"ñ" withString:@"&ndash;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"ô" withString:@"&trade;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"±" withString:@"&plusmn;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"ì" withString:@"&ldquo;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"î" withString:@"&rdquo;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"Æ" withString:@"&reg;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];
	
	[workString replaceOccurrencesOfString:@"í" withString:@"&rsquo;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [workString length])];

	return (NSString *)workString;
}

// Intercept link activation in HTML page
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request 
 navigationType:(UIWebViewNavigationType)navigationType 
{
	NSURL *url = request.URL;
	NSString *urlString = url.absoluteString;
	
	//	NSLog(@"%@", urlString);
	
	if ([urlString hasPrefix:@"jbh:"])
	{	 
		[self processInterruptedURL:urlString];
		return NO;
	}
	
	return YES;		// OK to process URL as is -- NO, if you want to do something else
}

- (void)processInterruptedURL:(NSString *)url 
{
	if ([url isEqualToString:@"jbh:requestHardCopy"])
	{
		[self requestReport];
	}
}

- (void)requestReport
{
	if (! [MFMailComposeViewController canSendMail])
	{
		UIAlertView *noEmailAlert = [[UIAlertView alloc]
									 initWithTitle:@"Cannot Send Email"
									 message:@"Unfortunately your device is\ncurrently not configured for\nsending email."
									 delegate:self
									 cancelButtonTitle:@"Dismiss"
									 otherButtonTitles:
									 nil];
		[noEmailAlert show];
		
		return;
	}
	
	RequestViewController *requestVC = [[RequestViewController alloc] initWithNibName:@"RequestViewController" bundle:nil];
	
	if ( ! iPadDevice )
	{
		requestVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
		
		[self presentModalViewController:requestVC animated:YES];
	}
	else 
	{
		requestPopoverController = [[UIPopoverController alloc] initWithContentViewController:requestVC];
		
		requestVC.requestPopoverController = self.requestPopoverController;
		requestVC.iPadDevice = iPadDevice;
		
		[requestPopoverController setDelegate:(id)self];
		[requestPopoverController setPopoverContentSize:requestVC.view.frame.size];
		[requestPopoverController presentPopoverFromRect:CGRectMake(0, 0, 768, 40) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
	}
}

- (void)emailRequest:(NSNotification *)notification
{
	[self performSelector:@selector(createEmail) withObject:nil afterDelay:iPadDevice ? 0.3 : 1.0];
}

- (void)createEmail
{
	MFMailComposeViewController *mailComposeController = [[MFMailComposeViewController alloc] init];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	mailComposeController.mailComposeDelegate = self;
	[mailComposeController setToRecipients:[NSArray arrayWithObject:@"Cheryl.Passalaqua@olympus.com"]];
	[mailComposeController setSubject:@"Request for Hard Copy of Clinical Study"];
	[mailComposeController setMessageBody:[NSString stringWithFormat:@"<B>Clinical Study Requested:</B><BR><BR>%@<BR><BR><B>Author:</B> %@<BR><BR><B>Copies Requested:</B> %@<BR><BR><B>Ship To:</B><BR><BR>%@<BR>%@%@, %@, %@<BR><BR>Attn: </B>%@<BR>",
										   gyrus2model.articleTitle, 
										   gyrus2model.author,
										   [defaults stringForKey:@"textFieldCopies"],
										   [defaults stringForKey:@"textFieldAddress1"],
										   [[defaults stringForKey:@"textFieldAddress2"] length] == 0 ? @"" :
										   [NSString stringWithFormat:@"%@<BR>", [defaults stringForKey:@"textFieldAddress2"]],
										   [defaults stringForKey:@"textFieldCity"],
										   [defaults stringForKey:@"textFieldState"],
										   [defaults stringForKey:@"textFieldZip"],
										   [defaults stringForKey:@"textFieldAttentionTo"]] 
								   isHTML:YES];
	
	mailComposeController.navigationController.navigationBar.tintColor = [UIColor blackColor];

	[self presentModalViewController:mailComposeController animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	NSString *results;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			results = @"Cancelled";
			break;
		case MFMailComposeResultSaved:
			results = @"Your email has been saved\nand will be sent when\nconnectivity is available.";
			break;
		case MFMailComposeResultSent:
			results = @"Your email is being sent.";
			break;
		case MFMailComposeResultFailed:
			results = @"Your email failed\nReason unspecified.";
			break;
		default:
			results = @"Your email was not sent.";
			break;
	}
	
	if (! [results isEqualToString:@"Cancelled"])
	{
		UIAlertView *resultsAlert = [[UIAlertView alloc]
									 initWithTitle:@"Email Status"
									 message:results
									 delegate:self
									 cancelButtonTitle:@"OK"
									 otherButtonTitles:nil];
		[resultsAlert show];
	}
	
	[self dismissModalViewControllerAnimated:YES];
}

@end
