//
//  TrFadeAnimation.h
//  TrAnimate
//
//  Created by Kristian Trenskow on 21/08/14.
//  Copyright (c) 2014 Kristian Trenskow. All rights reserved.
//

#import <TrAnimate/TrAnimate.h>

typedef NS_ENUM(NSInteger, TrFadeAnimationDirection) {
    TrFadeAnimationDirectionIn = 0,
    TrFadeAnimationDirectionOut
};

@interface TrFadeAnimation : TrOpacityAnimation

/// --------------------------
/// @name Creating Animaitions
/// --------------------------

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrFadeAnimationDirection)direction
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrFadeAnimationDirection)direction
                  curve:(TrCurve *)curve;

+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrFadeAnimationDirection)direction;

@end
