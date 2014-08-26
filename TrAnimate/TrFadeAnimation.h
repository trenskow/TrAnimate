//
//  TrCurve.h
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

#import "TrOpacityAnimation.h"

/*!
 Specifies the fade direction.
 */
typedef NS_ENUM(NSInteger, TrFadeAnimationDirection) {
    /*! Fade in. */
    TrFadeAnimationDirectionIn = 0,
    /*! Fade out. */
    TrFadeAnimationDirectionOut
};

/*!
 The `TrFadeAnimation` fades in or out a `UIView` or `CALayer`.
 */
@interface TrFadeAnimation : TrOpacityAnimation

/// --------------------------
/// @name Creating Animaitions
/// --------------------------

/*!
 Creates and returns an animation that fades in or out a `UIView` or `CALayer`.

 @param viewOrLayer The `UIView` or `CALayer` you want to fade.
 @param duration    The duration of the fade.
 @param delay       The delay before the fade begins.
 @param direction   Indicates if the animation should fade in or out.
 @param curve       A curvature for the animation.
 @param completion  A block that gets invokes when the animation completes.

 @return An fade animation ready to animate.
*/
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrFadeAnimationDirection)direction
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

/*!
 Creates and returns an animation that fades in or out a `UIView` or `CALayer`.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to fade.
 @param duration    The duration of the fade.
 @param delay       The delay before the fade begins.
 @param direction   Indicates if the animation should fade in or out.
 @param curve       A curvature for the animation.
 
 @return An fade animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrFadeAnimationDirection)direction
                  curve:(TrCurve *)curve;

/*!
 Creates and returns an animation that fades in or out a `UIView` or `CALayer`.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to fade.
 @param duration    The duration of the fade.
 @param delay       The delay before the fade begins.
 @param direction   Indicates if the animation should fade in or out.
 
 @discussion Creates an animation with a linear curvature to it.
 
 @return An fade animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              direction:(TrFadeAnimationDirection)direction;

@end
