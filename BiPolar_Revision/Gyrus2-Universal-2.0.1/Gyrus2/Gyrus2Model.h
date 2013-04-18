//
//  Gyrus2Model.h
//  Gyrus2
//
//  Created by James Hollender on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define OUTCOME 1
#define PROCEDURE 2
#define AUTHOR 3

@interface Gyrus2Model : NSObject

@property (nonatomic, strong) NSString *outcome;
@property (nonatomic, strong) NSString *procedure;
@property (nonatomic, strong) NSString *productLine;
@property (nonatomic, strong) NSString *product;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *competingProcess;
@property (nonatomic, strong) NSString *paperType;
@property (nonatomic, strong) NSString *articleTitle;
@property (nonatomic, strong) NSString *reference;
@property (nonatomic, strong) NSString *outcomeOrComments;
@property (nonatomic, strong) NSString *abstract;
@property (nonatomic, strong) NSString *hyperlink;
@property (nonatomic, assign) NSInteger listType;

@end
