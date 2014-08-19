//
//  TrDirectAnimation.h
//  TrAnimate
//
//  Copyright (c) 2014, Kristian Trenskow All rights reserved.
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

#import "TrAnimation.h"

@protocol TrInterpolatable;

/**
 *  The `TrDirectAnimation` class enables animating anything not normally animatable. The `TrDirectAnimation` does not use Core Animation. Instead it sets the values of properties directly on objects. This is useful when you want to animate as an example the `contentOffset` of a `UIScrollView` instance - or the `volume` property of a `AVAudioPlayer` instance.
 */
@interface TrDirectAnimation : NSObject <TrAnimation>

/// ---------------------------
/// @name Creating an Animation
/// ---------------------------

/**
 *  Creates and returns an animation with a start value and an end value.
 *
 *  @param object     The object which key path you want to animate.
 *  @param keyPath    The key path of the animated property.
 *  @param duration   The duration of the animation.
 *  @param delay      The delay before the animation begins.
 *  @param startValue The start value of the property.
 *  @param endValue   The end value of the property.
 *  @param curve      The curvature of the animation. Providing `nil` makes the animation linear.
 *  @param completion A block that is invoked when the animation has completed.
 *
 *  @return An animation ready to animate.
 */
+ (instancetype)animate:(id)object
                keyPath:(NSString *)keyPath
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
             startValue:(id<TrInterpolatable>)startValue
               endValue:(id<TrInterpolatable>)endValue
                  curve:(TrCurve *)curve
             completion:(void(^)(BOOL finished))completion;

/**
 *  Creates and returns an animation with an end value. The start value is the current value of the key path.
 *
 *  @param object     The object which key path you want to animate.
 *  @param keyPath    The key path of the animated property.
 *  @param duration   The duration of the animation.
 *  @param delay      The delay before the animation begins.
 *  @param endValue   The end value of the property.
 *  @param curve      The curvature of the animation. Providing `nil` makes the animation linear.
 *  @param completion A block that is invoked when the animation has completed.
 *
 *  @return An animation ready to animate.
 */
+ (instancetype)animate:(id)object
                keyPath:(NSString *)keyPath
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
               endValue:(id<TrInterpolatable>)endValue
                  curve:(TrCurve *)curve
             completion:(void(^)(BOOL finished))completion;

@end
