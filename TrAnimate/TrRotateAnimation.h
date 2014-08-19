//
//  TrRotateAnimation.h
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
 *  Speciefies the rotation axis.
 */
typedef NS_OPTIONS(NSUInteger, TrRotateAnimationOptions) {
    /**
     *  Rotate around the z-axis. Default.
     */
    kTrRotateAnimationOptionsAxisZ = 0,
    /**
     *  Rotate around the x-axis.
     */
    kTrRotateAnimationOptionsAxisX,
    /**
     *  Rotate around the y-axis.
     */
    kTrRotateAnimationOptionsAxisY
};

/**
 *  A animation that rotates a `UIView` or `CALayer` around an axis.
 */
@interface TrRotateAnimation : TrKeyPathAnimation

/// -------------------------
/// @name Creating Animations
/// -------------------------

/**
 *  Creates and returns a new rotation animation.
 *
 *  @param viewOrLayer The `UIView` or `CALayer` you want to animate.
 *  @param duration    The duration of the animation.
 *  @param delay       The delay before the animation begins.
 *  @param startAngle  The start angle of the rotation.
 *  @param endAngle    The end angle of the rotation.
 *
 *  @return An animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
             startAngle:(CGFloat)startAngle
               endAngle:(CGFloat)endAngle;

/**
 *  Creates and returns a new rotation animation.
 *
 *  @param viewOrLayer The `UIView` or `CALayer` you want to animate.
 *  @param duration    The duration of the animation.
 *  @param delay       The delay of the animation.
 *  @param startAngle  The start angle of the rotation.
 *  @param endAngle    The end angle of the rotation.
 *  @param options     Options indicating the axis on which the animation will occur.
 *
 *  @return An animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
             startAngle:(CGFloat)startAngle
               endAngle:(CGFloat)endAngle
                options:(TrRotateAnimationOptions)options;

/**
 *  Creates and returns a new rotation animation.
 *
 *  @param viewOrLayer The `UIView` or `CALayer` you want to animate.
 *  @param duration    The duration of the animation.
 *  @param delay       The delay before the animation begins.
 *  @param startAngle  The start angle of the rotation.
 *  @param endAngle    The end angle of the rotation.
 *  @param curve       The curvature of the animation. Providing `nil` makes a linear animation.
 *  @param completion  A block that gets invoked when the animation completes.
 *
 *  @return An animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
             startAngle:(CGFloat)startAngle
               endAngle:(CGFloat)endAngle
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

/**
 *  Creates and returns a new rotation animation.
 *
 *  @param viewOrLayer The `UIView` or `CALayer` you want to animate.
 *  @param duration    The duration of the animation.
 *  @param delay       The delay before the animation begins.
 *  @param startAngle  The start angle of the rotation.
 *  @param endAngle    The end angle of the rotation.
 *  @param options     Options indicating the axis on which the animation will occur.
 *  @param curve       The curvature of the animation. Providing `nil` makes a linear animation.
 *  @param completion  A block that gets invoked when the animation completes.
 *
 *  @return An animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
             startAngle:(CGFloat)startAngle
               endAngle:(CGFloat)endAngle
                options:(TrRotateAnimationOptions)options
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

@end
