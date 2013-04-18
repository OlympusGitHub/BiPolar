//
//  Outcome1ViewController.h
//  Gyrus2
//
//  Created by James Hollender on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gyrus2Model.h"
#import "AppDelegate.h"

@interface Outcome1ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *labelPK;
@property (strong, nonatomic) IBOutlet UILabel *labelOlympus;
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) NSMutableArray *modelArrayOlympus;
@property (nonatomic, strong) NSMutableArray *modelArrayPK;
@property (nonatomic, strong) NSMutableArray *sectionStarts;
@property (nonatomic, strong) NSMutableArray *sectionStartsOlympus;
@property (nonatomic, strong) NSMutableArray *sectionStartsPK;
@property (nonatomic, strong) NSMutableArray *passedArray;
@property (assign) BOOL iPadDevice;

- (IBAction)segmentedControlValueChanged:(id)sender;
- (void) readOutcomeFile;
- (void) addOutcomeField:(int)fcount withString:(NSString *)line3 toModel:(Gyrus2Model *)gyrus2model;
- (void) createSectionStarts:(NSMutableArray *)mySectionStarts fromModelArray:(NSMutableArray *)myModelArray;
- (NSString *) stringForTVC:(NSString *)string;
- (NSString *) stringForProduct:(NSString *)string;

@end
