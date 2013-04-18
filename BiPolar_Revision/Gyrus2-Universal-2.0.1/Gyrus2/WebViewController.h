//
//  WebViewController.h
//  Gyrus2
//
//  Created by James Hollender on 2/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Gyrus2Model.h"
#import "Web2ViewController.h"
#import "Web2ViewController_iPad.h"
#import "RequestViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface WebViewController : UIViewController <UIWebViewDelegate, MFMailComposeViewControllerDelegate>
{
	BOOL fromAuthorsPage;
	NSInteger listType;
}

@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) Gyrus2Model *gyrus2model;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *flexibleSpace;
@property (strong, nonatomic) UIPopoverController *requestPopoverController;
@property (assign) BOOL iPadDevice;

- (IBAction)buttonDoneTap:(id)sender;
- (IBAction)buttonMoreTap:(id)sender;
- (void)createAndDisplayHTML;
- (NSString *) stringForProduct:(NSString *)string;
- (NSString *) stringForGeneral:(NSString *)string;
- (void)processInterruptedURL:(NSString *)url;
- (void)emailTo:(NSString *)recipient requestForArticle:(NSString *)article by:(NSString *)author;
- (void)requestReport;
- (void)emailRequest:(NSNotification *)notification;
- (void)createEmail;

@end
