//
//  InfoViewController.h
//  Gyrus2
//
//  Created by James Hollender on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *labelVersion;

- (IBAction)buttonDoneTap:(id)sender;

@end
