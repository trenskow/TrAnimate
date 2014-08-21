//
//  TrFadeAnimation.m
//  TrAnimate
//
//  Created by Kristian Trenskow on 21/08/14.
//  Copyright (c) 2014 Kristian Trenskow. All rights reserved.
//

#import "TrAnimatable.h"

#import "TrFadeAnimation.h"

@implementation TrFadeAnimation

#pragma mark - Creating Animations

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrFadeAnimationDirection)direction
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion {
    
    return [super animate:viewOrLayer
                 duration:duration
                    delay:delay
              fromOpacity:viewOrLayer.presentedLayer.opacity
                toOpacity:(direction == TrFadeAnimationDirectionIn ? 1.0 : .0)
                    curve:curve
               completion:completion];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrFadeAnimationDirection)direction
                  curve:(TrCurve *)curve {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
               direction:direction
                   curve:curve
              completion:nil];
    
}

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrFadeAnimationDirection)direction {
    
    return [self animate:viewOrLayer
                duration:duration
                   delay:delay
               direction:direction
                   curve:nil
              completion:nil];
    
}

@end
