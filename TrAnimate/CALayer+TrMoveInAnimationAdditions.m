//
//  CALayer+TrMoveInAnimationAdditions.m
//  TrAnimate
//
//  Created by Kristian Trenskow on 01/09/14.
//  Copyright (c) 2014 Trenskow. All rights reserved.
//

#import "CALayer+TrMoveInAnimationAdditions.h"

@implementation CALayer (TrMoveInAnimationAdditions)

- (CALayer *)windowLayer {
    
    CALayer *windowLayer = self;
    while (windowLayer.superlayer)
        windowLayer = windowLayer.superlayer;
    
    return windowLayer;
    
}

@end
