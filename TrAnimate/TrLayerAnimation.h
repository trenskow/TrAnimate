//
//  TrLayerAnimation.h
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

@import QuartzCore;

#import "TrAnimation.h"

@protocol TrInterpolatable;
@class TrCurve;

/*!
 The `TrLayerAnimation` provides animation on any animatable property of CALayer. Use this animation if you need to do custom animations on a layer that is not directly implemented in TrAnimate as an explicit animation.
 */
@interface TrLayerAnimation : NSObject <TrAnimation>

/// --------------------------------
/// @name Examining Views and Layers
/// --------------------------------

/*!
*  Checks if an animation is in progress on a `UIView` or `CALayer` instance at a perticular property.
*
*  @param layer       The `CALayer` you want to examine.
*  @param keyPath     The key path of the property that you want to examine.
*
*  @return Returns `YES` if the `UIView` or `CALayer` is animating on the property of `keyPath`.
*/
+ (BOOL)inProgressOn:(CALayer *)layer withKeyPath:(NSString *)keyPath;

///------------------------------------
/// @name Getting Animation Information
///------------------------------------

/*!
 Returns the animated layer.
 */
@property (weak,readonly,nonatomic) CALayer *layer;

/*!
 The duration of the animation.
 */
@property (nonatomic) NSTimeInterval duration;

/// -------------------------
/// @name Creating Animations
/// -------------------------

/*!
 Creates and returns an animation that animates the key path of a layer.
 
 @param layer      The `CALayer` you want to animate.
 @param duration   The duration of the animation.
 @param delay      The delay before the animation begins.
 @param keyPath    The key path of the property you want to animate.
 @param fromValue  The value from which to animate from.
 @param toValue    The value from which to animate to.
 @param curve      The curvature of the animation.
 @param completion A block that gets invoked when the animation completes.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(CALayer *)layer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
              fromValue:(id<TrInterpolatable>)fromValue
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

/*!
 Creates and returns an animation that animates the key path of a layer.
 
 @param layer      The `CALayer` you want to animate.
 @param duration   The duration of the animation.
 @param delay      The delay before the animation begins.
 @param keyPath    The key path of the property you want to animate.
 @param fromValue  The value from which to animate from.
 @param toValue    The value from which to animate to.
 @param curve      The curvature of the animation.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(CALayer *)layer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
              fromValue:(id<TrInterpolatable>)fromValue
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve;

/*!
 Creates and returns an animation that animates the key path of a layer.
 
 @param layer      The `CALayer` you want to animate.
 @param duration   The duration of the animation.
 @param delay      The delay before the animation begins.
 @param keyPath    The key path of the property you want to animate.
 @param fromValue  The value from which to animate from.
 @param toValue    The value from which to animate to.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(CALayer *)layer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
              fromValue:(id<TrInterpolatable>)fromValue
                toValue:(id<TrInterpolatable>)toValue;

/*!
 Creates and returns an animation that animates the key path of a layer. The animation animates from the key path's current value.
 
 @param layer      The `CALayer` you want to animate.
 @param duration   The duration of the animation.
 @param delay      The delay before the animation begins.
 @param keyPath    The key path of the property you want to animate.
 @param toValue    The value from which to animate to.
 @param curve      The curvature of the animation.
 @param completion A block that gets invoked when the animation completes.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(CALayer *)layer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

/*!
 Creates and returns an animation that animates the key path of a layer. The animation animates from the key path's current value.
 
 @param layer      The `CALayer` you want to animate.
 @param duration   The duration of the animation.
 @param delay      The delay before the animation begins.
 @param keyPath    The key path of the property you want to animate.
 @param toValue    The value from which to animate to.
 @param curve      The curvature of the animation.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(CALayer *)layer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
                toValue:(id<TrInterpolatable>)toValue
                  curve:(TrCurve *)curve;

/*!
 Creates and returns an animation that animates the key path of a layer. The animation animates from the key path's current value.
 
 @param layer      The `CALayer` you want to animate.
 @param duration   The duration of the animation.
 @param delay      The delay before the animation begins.
 @param keyPath    The key path of the property you want to animate.
 @param toValue    The value from which to animate to.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(CALayer *)layer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                keyPath:(NSString *)keyPath
                toValue:(id<TrInterpolatable>)toValue;

@end
