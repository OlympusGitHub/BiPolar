//
//  GradientButton.h
//  GradientButtons
//
//  Created by Administrator on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface GradientButton : UIButton
{
    CAGradientLayer *shineLayer;
    CALayer         *highlightLayer;
}

@end
