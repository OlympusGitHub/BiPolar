//
//  AuthorsViewController.h
//  Gyrus2
//
//  Created by James Hollender on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gyrus2Model.h"
#import "AppDelegate.h"
#import "WebViewController.h"

@interface AuthorsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *labelAll;
@property (strong, nonatomic) IBOutlet UILabel *labelOlympus;
@property (strong, nonatomic) IBOutlet UILabel *labelPK;
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) NSMutableArray *modelArrayOlympus;
@property (nonatomic, strong) NSMutableArray *modelArrayPK;
@property (nonatomic, strong) NSMutableArray *sectionStarts;
@property (nonatomic, strong) NSMutableArray *sectionStartsOlympus;
@property (nonatomic, strong) NSMutableArray *sectionStartsPK;
@property (assign) BOOL iPadDevice;

- (IBAction)segmentedControlValueChanged:(id)sender;
- (void) readIndexFile;
- (void) addIndexField:(int)fcount withString:(NSString *)line3 toModel:(Gyrus2Model *)gyrus2model;
- (void) createSectionStarts:(NSMutableArray *)mySectionStarts fromModelArray:(NSMutableArray *)myModelArray;
- (NSString *) stringForTVC:(NSString *)string;

@end
