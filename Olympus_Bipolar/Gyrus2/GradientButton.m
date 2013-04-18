//
//  GradientButton.m
//  GradientButtons
//
//  Created by Administrator on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  http://undefinedvalue.com/2010/02/27/shiny-iphone-buttons-without-photoshop

#import "GradientButton.h"


@implementation GradientButton

- (void) initBorder
{
    CALayer *layer = self.layer;
    layer.cornerRadius = 4.0f;
    layer.masksToBounds = YES;
    layer.borderWidth = 1.0f;
    layer.borderColor = [UIColor colorWithWhite:0.5f alpha:0.2f].CGColor;
}

- (void) addShineLayer
{
    shineLayer = [CAGradientLayer layer];
    
    shineLayer.frame = self.layer.bounds;
    
    shineLayer.colors = [NSArray arrayWithObjects:
                         (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.75f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.4f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                         nil];
    
    shineLayer.locations = [NSArray arrayWithObjects:
                            [NSNumber numberWithFloat:0.0f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.8f],
                            [NSNumber numberWithFloat:1.0f],
                            nil];
    
    [self.layer addSublayer:shineLayer];
}

- (void) addHighlightLayer
{
    highlightLayer = [CALayer layer];
    highlightLayer.backgroundColor = [UIColor colorWithRed:0.25f green:0.25f blue:0.25f alpha:0.75].CGColor;
    highlightLayer.frame = self.layer.bounds;
    highlightLayer.hidden = YES;
    [self.layer insertSublayer:highlightLayer above:shineLayer];
}

- (void) initLayers
{
    [self initBorder];
    [self addShineLayer];
    [self addHighlightLayer];
}

- (void) awakeFromNib
{
    [self initLayers];
}

- (id) initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        [self initLayers];
    }
    
    return self;
}

- (void) setHighlighted:(BOOL)highlighted
{
    highlightLayer.hidden = !highlighted;
    [super setHighlighted:highlighted];
}

- (void) layoutSubviews
{
    [shineLayer setFrame:[self bounds]];
    [highlightLayer setFrame:[self bounds]];
    [super layoutSubviews];
}

@end
