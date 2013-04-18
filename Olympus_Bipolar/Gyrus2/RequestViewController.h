//
//  RequestViewController.h
//  Gyrus2
//
//  Created by James Hollender on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface RequestViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textFieldAttentionTo;
@property (strong, nonatomic) IBOutlet UITextField *textFieldAddress1;
@property (strong, nonatomic) IBOutlet UITextField *textFieldAddress2;
@property (strong, nonatomic) IBOutlet UITextField *textFieldCity;
@property (strong, nonatomic) IBOutlet UITextField *textFieldState;
@property (strong, nonatomic) IBOutlet UITextField *textFieldZip;
@property (strong, nonatomic) IBOutlet UITextField *textFieldCopies;
@property (strong, nonatomic) IBOutlet UILabel *labelAuthor;
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) UIPopoverController *requestPopoverController;
@property BOOL iPadDevice;

- (IBAction)buttonCancelTap:(id)sender;
- (IBAction)bujttonCreateEmailTap:(id)sender;

@end
