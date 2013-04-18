//
//  Web2ViewController_iPad.h
//  Gyrus2
//
//  Created by James Hollender on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gyrus2Model.h"

@interface Web2ViewController_iPad : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) Gyrus2Model *gyrus2model;

- (IBAction)buttonDoneTap:(id)sender;

@end
