//
//  CALayer+TrMoveAnimationAdditions.m
//  TrAnimate
//
//  Created by Kristian Trenskow on 02/01/14.
//  Copyright (c) 2014 Kristian Trenskow. All rights reserved.
//

#import "CALayer+TrMoveAnimationAdditions.h"

@implementation CALayer (TrMoveAnimationAdditions)

#pragma mark - Properties

- (CALayer *)topLayer {
    
    if (self.superlayer)
        return [self.superlayer topLayer];
    
    return self;
    
}

@end
