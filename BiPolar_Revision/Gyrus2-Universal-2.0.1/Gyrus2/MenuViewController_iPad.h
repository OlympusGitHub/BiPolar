//
//  MenuViewController_iPad.h
//  Gyrus2
//
//  Created by James Hollender on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradientButton.h"
#import "Outcome1ViewController.h"
#import "Procedure1ViewController.h"
#import "AuthorsViewController.h"

@interface MenuViewController_iPad : UIViewController

@property (strong, nonatomic) IBOutlet UIView *viewOneTime;
@property (strong, nonatomic) IBOutlet UILabel *lableClinicalStudy;

- (IBAction)buttonOutcomesTap:(id)sender;
- (IBAction)buttonProceduresTap:(id)sender;
- (IBAction)buttonIndexTap:(id)sender;

@end
