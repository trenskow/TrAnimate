//
//  TrMoveInAnimation.h
//  TrAnimate
//
//  Copyright (c) 2013-2014, Kristian Trenskow
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice,
//  this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.
//

#import <TrAnimate/TrAnimate.h>

/*!
 Specifies the direction from where the move-in should occur.
 */
typedef NS_ENUM(NSInteger, TrMoveInAnimationDirection) {
    /*!
     Move in from the top.
     */
    TrMoveInAnimationDirectionTop = 0,
    /*!
     Move in from the right.
     */
    TrMoveInAnimationDirectionRight,
    /*!
     Move in from the bottom.
     */
    TrMoveInAnimationDirectionBottom,
    /*!
     Move in from the left.
     */
    TrMoveInAnimationDirectionLeft
};

/*!
 Specifies the bounds from which the move-in should occur.
 */
typedef NS_ENUM(NSInteger, TrMoveInAnimationBounds) {
    /*!
     Move in from outside animated content's bounds.
     */
    TrMoveInAnimationBoundsContent = 0,
    /*!
     Move in from outside animated content's superview or superlayer bounds.
     */
    TrMoveInAnimationBoundsSuper,
    /*!
     Move in from outside animated content's window.
     */
    TrMoveInAnimationBoundsWindow
};

/*!
 The `TrMoveInAnimation` moves in a view from a specific direction and from outside some specified bounds.
 */
@interface TrMoveInAnimation : TrPositionAnimation

/// ------------------------
/// @name Creating Animation
/// ------------------------

/*!
 Creates and returns an animation that moves-in a `UIView` or `CALayer` object from a specific direction and outside the specified bounds.
 
 @param viewOrLayer The `UIView` or `CALayer` object you want to animate.
 @param duration    The duration of the animation.
 @param delay       The delay before the animation begins.
 @param direction   The direction from which the move-in should occur.
 @param bounds      The bounds the move-in should occur from outside.
 @param curve       The curvature to the animation.
 @param completion  A block that gets invokes when animation completes.
 
 @return A move-in animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrMoveInAnimationDirection)direction
                 bounds:(TrMoveInAnimationBounds)bounds
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

/*!
 Creates and returns an animation that moves-in a `UIView` or `CALayer` object from a specific direction and outside the specified bounds.
 
 @param viewOrLayer The `UIView` or `CALayer` object you want to animate.
 @param duration    The duration of the animation.
 @param delay       The delay before the animation begins.
 @param direction   The direction from which the move-in should occur.
 @param bounds      The bounds the move-in should occur from outside.
 @param curve       The curvature to the animation.
 
 @return A move-in animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrMoveInAnimationDirection)direction
                 bounds:(TrMoveInAnimationBounds)bounds
                  curve:(TrCurve *)curve;

/*!
 Creates and returns an animation that moves-in a `UIView` or `CALayer` object from a specific direction and outside the specified bounds.
 
 @param viewOrLayer The `UIView` or `CALayer` object you want to animate.
 @param duration    The duration of the animation.
 @param delay       The delay before the animation begins.
 @param direction   The direction from which the move-in should occur.
 @param bounds      The bounds the move-in should occur from outside.
 
 @return A move-in animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrMoveInAnimationDirection)direction
                 bounds:(TrMoveInAnimationBounds)bounds;

/*!
 Creates and returns an animation that moves-in a `UIView` or `CALayer` object from a specific direction and from ouside the `UIView` or `CALayer` object's bounds.
 
 @param viewOrLayer The `UIView` or `CALayer` object you want to animate.
 @param duration    The duration of the animation.
 @param delay       The delay before the animation begins.
 @param direction   The direction from which the move-in should occur.
 @param curve       The curvature to the animation.
 @param completion  A block that gets invokes when animation completes.
 
 @return A move-in animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrMoveInAnimationDirection)direction
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

/*!
 Creates and returns an animation that moves-in a `UIView` or `CALayer` object from a specific direction and from ouside the `UIView` or `CALayer` object's bounds.
 
 @param viewOrLayer The `UIView` or `CALayer` object you want to animate.
 @param duration    The duration of the animation.
 @param delay       The delay before the animation begins.
 @param direction   The direction from which the move-in should occur.
 @param curve       The curvature to the animation.

 @return A move-in animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrMoveInAnimationDirection)direction
                  curve:(TrCurve *)curve;

/*!
 Creates and returns an animation that moves-in a `UIView` or `CALayer` object from a specific direction and from ouside the `UIView` or `CALayer` object's bounds.
 
 @param viewOrLayer The `UIView` or `CALayer` object you want to animate.
 @param duration    The duration of the animation.
 @param delay       The delay before the animation begins.
 @param direction   The direction from which the move-in should occur.
 
 @return A move-in animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrMoveInAnimationDirection)direction;

@end
