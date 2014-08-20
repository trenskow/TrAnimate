//
//  TrScaleAnimation.h
//  TrAnimate
//
//  Copyright (c) 2013, Kristian Trenskow All rights reserved.
//
//  Redistribution and use in source and binary forms, with or
//  without modification, are permitted provided that the following
//  conditions are met:
//
//  Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//  Redistributions in binary form must reproduce the above
//  copyright notice, this list of conditions and the following
//  disclaimer in the documentation and/or other materials provided
//  with the distribution. THIS SOFTWARE IS PROVIDED BY THE
//  COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
//  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
//  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER
//  OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
//  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
//  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
//  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
//  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
//  STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "TrKeyPathAnimation.h"

/**
 *  The `TrScaleAnimation` scales a `UIView` or `CALayer`.
 */
@interface TrScaleAnimation : TrKeyPathAnimation

/// --------------------------------
/// @name Examining Views and Layers
/// --------------------------------

/**
 *  Checks if a scale animation is in progress on a `UIView` or `CALayer` instance.
 *
 *  @param viewOrLayer The `UIView` or `CALayer` you want to examine.
 *
 *  @return Returns `YES` if the `UIView` or `CALayer` has a scale animation in progress.
 */
+ (BOOL)inProgressOn:(id<TrAnimatable>)viewOrLayer;

/// --------------------------
/// @name Creating Animaitions
/// --------------------------

/**
 *  Creates and returns a scale animation.
 *
 *  @param viewOrLayer      The `UIView` or `CALayer` you want to animate.
 *  @param duration         The duration of the animation.
 *  @param delay            The delay before the animation begins.
 *  @param startScaleFactor The start scale factor of the animation.
 *  @param endScaleFactor   The end scale factor of the animation.
 *  @param curve            The curvature of the animation. Providing `nil` makes the animation linear.
 *  @param completion       A block that gets invoked when the animation completes.
 *
 *  @return An animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
       startScaleFactor:(CGFloat)startScaleFactor
         endScaleFactor:(CGFloat)endScaleFactor
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

/**
 *  Creates and returns a scale animation. The animations start scale factor will be the `UIView`s or `CALayer`s current scale value.
 *
 *  @param viewOrLayer    The `UIView` or `CALayer` you want to animate.
 *  @param duration       The duration of the animation.
 *  @param delay          The delay before the animation begins.
 *  @param endScaleFactor The end scale factor of the animation.
 *  @param curve          The curvature of the animation. Providing `nil` makes the animation linear.
 *  @param completion     A block that gets invoked when the animation completes.
 *
 *  @return An animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
         endScaleFactor:(CGFloat)endScaleFactor
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

/**
 *  Creates an returns a scale animation.
 *
 *  @param viewOrLayer      The `UIView` or `CALayer` you want to animate.
 *  @param duration         The duration of the animation.
 *  @param delay            The delay before the animation begins.
 *  @param startScaleFactor The start scale factor of the animation.
 *  @param endScaleFactor   The end scale factor of the animation.
 *
 *  @return An animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
       startScaleFactor:(CGFloat)startScaleFactor
         endScaleFactor:(CGFloat)endScaleFactor;

@end
