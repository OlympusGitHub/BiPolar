//
//  Procedure2ViewController.h
//  Gyrus2
//
//  Created by James Hollender on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gyrus2Model.h"
#import "AppDelegate.h"
#import "WebViewController.h"

@interface Procedure2ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (assign) BOOL iPadDevice;

- (NSString *) stringForTVC:(NSString *)string;
- (NSString *) stringForProduct:(NSString *)string;

@end
