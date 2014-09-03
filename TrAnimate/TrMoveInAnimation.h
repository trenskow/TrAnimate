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

#import "TrPositionAnimation.h"

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
 The `TrMoveInAnimation` moves in a view from a specific direction and from outside some specified bounds.
 
 ## Usage
 
 This animation implicitly unhides the animated content before the animation begins. Use this by moving your content into place and hide it.
 
     self.someView.frame = CGRectMake(100.0, 100.0, 100.0, 100.0);
     self.someView.hidden = YES;
     
     [TrMoveInAnimation animate:self.someView
                       duration:.3
                          delay:.0
                      direction:TrMoveInAnimationDirectionTop
              fromOutsideBounds:self.someView.superview
                          curve:[TrCurve easeOutBack]];
 
  In the above example we set the frame of a `UIView` object (`someView`) and immediately hide it. The animation then unhides the `UIView` object and animates it from outside it's superview's bounds and into place.
 
 ## Convenience methods
 
 There are some convenience methods for creating move-in animation on `UIView` objects which are described in the reference for UIView(TrMoveInAnimationAdditions).
 
 */
@interface TrMoveInAnimation : TrPositionAnimation

/// ------------------------
/// @name Creating Animation
/// ------------------------

/*!
 Creates and returns an animation that moves-in a `UIView` or `CALayer` object from a specific direction and outside the specified bounds.
 
 @param viewOrLayer       The `UIView` or `CALayer` object you want to animate.
 @param duration          The duration of the animation.
 @param delay             The delay before the animation begins.
 @param direction         The direction from which the move-in should occur.
 @param boundsViewOrLayer The `UIView` or `CALayer` object from outside which bounds the move-in should occur. If nil is provided the bounds of the `UIView` or `CALayer` object provided in `viewOrLayer` will be used.
 @param curve             The curvature to the animation.
 @param completion        A block that gets invokes when animation completes.
 
 @return A move-in animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrMoveInAnimationDirection)direction
      fromOutsideBounds:(id<TrAnimatable>)boundsViewOrLayer
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

/*!
 Creates and returns an animation that moves-in a `UIView` or `CALayer` object from a specific direction and outside the specified bounds.
 
 @param viewOrLayer       The `UIView` or `CALayer` object you want to animate.
 @param duration          The duration of the animation.
 @param delay             The delay before the animation begins.
 @param direction         The direction from which the move-in should occur.
 @param boundsViewOrLayer The `UIView` or `CALayer` object from outside which bounds the move-in should occur. If nil is provided the bounds of the `UIView` or `CALayer` object provided in `viewOrLayer` will be used.
 @param curve             The curvature to the animation.
 
 @return A move-in animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrMoveInAnimationDirection)direction
      fromOutsideBounds:(id<TrAnimatable>)boundsViewOrLayer
                  curve:(TrCurve *)curve;

/*!
 Creates and returns an animation that moves-in a `UIView` or `CALayer` object from a specific direction and outside the specified bounds.
 
 @param viewOrLayer       The `UIView` or `CALayer` object you want to animate.
 @param duration          The duration of the animation.
 @param delay             The delay before the animation begins.
 @param direction         The direction from which the move-in should occur.
 @param boundsViewOrLayer The `UIView` or `CALayer` object from outside which bounds the move-in should occur. If nil is provided the bounds of the `UIView` or `CALayer` object provided in `viewOrLayer` will be used.
 
 @return A move-in animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrMoveInAnimationDirection)direction
      fromOutsideBounds:(id<TrAnimatable>)boundsViewOrLayer;

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
