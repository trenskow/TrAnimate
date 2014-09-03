//
//  UIView+TrMoveInAnimationAdditions.h
//  TrAnimate
//
//  Created by Kristian Trenskow on 03/09/14.
//  Copyright (c) 2014 Trenskow. All rights reserved.
//

@import UIKit;

#import "TrMoveInAnimation.h"

@protocol TrAnimatable;
@class TrCurve;

/*!
 A category to `UIView` with convenience methods to create move-in animations.
 */
@interface UIView (TrMoveInAnimationAdditions)

/// ---------------
/// @name Moving in
/// ---------------

/*!
 Creates and returns a move-in animation.
 
 @param duration          The duration of the move-in.
 @param direction         The direction from which the move-in should occor.
 @param delay             The delay before the move-in begins.
 @param boundsViewOrLayer The `UIView` or `CALayer` object from outside which bounds the move-in should occur. If nil is provided the bounds of the `UIView` or `CALayer` object provided in `viewOrLayer` will be used.
 @param curve             The curvateure of the move-in.
 @param completion        A block that gets invoked when move-in completes.
 
 @return A move-in animation ready to animate.
 */
- (TrMoveInAnimation *)moveIn:(NSTimeInterval)duration
                    direction:(TrMoveInAnimationDirection)direction
                        delay:(NSTimeInterval)delay
             fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer
                        curve:(TrCurve *)curve
                   completion:(void (^)(BOOL finished))completion;

/*!
 Creates and returns a move-in animation.
 
 @param duration          The duration of the move-in.
 @param direction         The direction from which the move-in should occor.
 @param delay             The delay before the move-in begins.
 @param boundsViewOrLayer The `UIView` or `CALayer` object from outside which bounds the move-in should occur. If nil is provided the bounds of the `UIView` or `CALayer` object provided in `viewOrLayer` will be used.
 @param curve             The curvateure of the move-in.
 
 @return A move-in animation ready to animate.
 */
- (TrMoveInAnimation *)moveIn:(NSTimeInterval)duration
                    direction:(TrMoveInAnimationDirection)direction
                        delay:(NSTimeInterval)delay
             fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer
                        curve:(TrCurve *)curve;

/*!
 Creates and returns a move-in animation.
 
 @param duration          The duration of the move-in.
 @param direction         The direction from which the move-in should occor.
 @param delay             The delay before the move-in begins.
 @param boundsViewOrLayer The `UIView` or `CALayer` object from outside which bounds the move-in should occur. If nil is provided the bounds of the `UIView` or `CALayer` object provided in `viewOrLayer` will be used.
 
 @return A move-in animation ready to animate.
 */
- (TrMoveInAnimation *)moveIn:(NSTimeInterval)duration
                    direction:(TrMoveInAnimationDirection)direction
                        delay:(NSTimeInterval)delay
             fromOusideBounds:(id<TrAnimatable>)boundsViewOrLayer;

/*!
 Creates and returns a move-in animation.
 
 @param duration          The duration of the move-in.
 @param direction         The direction from which the move-in should occor.
 @param delay             The delay before the move-in begins.
 
 @return A move-in animation ready to animate.
 */
- (TrMoveInAnimation *)moveIn:(NSTimeInterval)duration
                    direction:(TrMoveInAnimationDirection)direction
                        delay:(NSTimeInterval)delay;

/*!
 Creates and returns a move-in animation.
 
 @param duration          The duration of the move-in.
 @param direction         The direction from which the move-in should occor.
 
 @return A move-in animation ready to animate.
 */
- (TrMoveInAnimation *)moveIn:(NSTimeInterval)duration
                    direction:(TrMoveInAnimationDirection)direction;

@end
