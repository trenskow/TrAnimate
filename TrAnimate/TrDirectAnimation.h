//
//  TrDirectAnimation.h
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

#import "TrAnimation.h"

@protocol TrInterpolatable;

/*!
 The `TrDirectAnimation` class enables animating anything not normally animatable. The `TrDirectAnimation` does not use Core Animation. Instead it sets the values of properties directly on objects. This is useful when you want to animate as an example the `contentOffset` of a `UIScrollView` instance - or the `volume` property of a `AVAudioPlayer` instance.
 */
@interface TrDirectAnimation : NSObject <TrAnimation>

/// ---------------------------
/// @name Creating an Animation
/// ---------------------------

/*!
 Creates and returns an animation that is driven by directly manipulating the key path of an object on every screen update.
 
 @param object     The object which property you want to animate.
 @param duration   The duration of the animation.
 @param delay      The delay before the animation begins.
 @param keyPath    The key path of the property.
 @param fromValue  The value from which the property will animate from.
 @param toValue    The value from which the property will animate to.
 @param curve      The curvature of the animation.
 @param completion A block that gets invokes when the animation completes.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(id)object
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
              fromValue:(id<TrInterpolatable>)fromValue
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

/*!
 Creates and returns an animation that is driven by directly manipulating the key path of an object on every screen update.
 
 @param object     The object which property you want to animate.
 @param duration   The duration of the animation.
 @param delay      The delay before the animation begins.
 @param keyPath    The key path of the property.
 @param fromValue  The value from which the property will animate from.
 @param toValue    The value from which the property will animate to.
 @param curve      The curvature of the animation.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(id)object
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
              fromValue:(id<TrInterpolatable>)fromValue
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve;

/*!
 Creates and returns an animation that is driven by directly manipulating the key path of an object on every screen update.
 
 @param object     The object which property you want to animate.
 @param duration   The duration of the animation.
 @param delay      The delay before the animation begins.
 @param keyPath    The key path of the property.
 @param fromValue  The value from which the property will animate from.
 @param toValue    The value from which the property will animate to.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(id)object
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
              fromValue:(id<TrInterpolatable>)fromValue
                toValue:(id<TrInterpolatable>)toValue;

/*!
 Creates and returns an animation that is driven by directly manipulating the key path of an object on every screen update. The animation animates from the property's current value.
 
 @param object     The object which property you want to animate.
 @param duration   The duration of the animation.
 @param delay      The delay before the animation begins.
 @param keyPath    The key path of the property.
 @param toValue    The value from which the property will animate to.
 @param curve      The curvature of the animation.
 @param completion A block that gets invokes when the animation completes.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(id)object
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

/*!
 Creates and returns an animation that is driven by directly manipulating the key path of an object on every screen update. The animation animates from the property's current value.
 
 @param object     The object which property you want to animate.
 @param duration   The duration of the animation.
 @param delay      The delay before the animation begins.
 @param keyPath    The key path of the property.
 @param toValue    The value from which the property will animate to.
 @param curve      The curvature of the animation.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(id)object
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve;

/*!
 Creates and returns an animation that is driven by directly manipulating the key path of an object on every screen update. The animation animates from the property's current value.
 
 @param object     The object which property you want to animate.
 @param duration   The duration of the animation.
 @param delay      The delay before the animation begins.
 @param keyPath    The key path of the property.
 @param toValue    The value from which the property will animate to.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(id)object
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
                toValue:(id<TrInterpolatable>)toValue;

@end
