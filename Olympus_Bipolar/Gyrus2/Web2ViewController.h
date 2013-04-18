//
//  Web2ViewController.h
//  Gyrus2
//
//  Created by James Hollender on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradientButton.h"
#import "Gyrus2Model.h"
#import "AppDelegate.h"

@interface Web2ViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet GradientButton *buttonBack;
@property (strong, nonatomic) IBOutlet GradientButton *buttonForward;
@property (strong, nonatomic) IBOutlet GradientButton *buttonReload;
@property (strong, nonatomic) IBOutlet GradientButton *buttonStop;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) Gyrus2Model *gyrus2model;
@property (assign) BOOL iPadDevice;

- (IBAction)buttonDoneTap:(id)sender;

@end
