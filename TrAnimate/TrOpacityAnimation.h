//
//  TrOpacityAnimation.h
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

#import "TrLayerAnimation.h"

/*!
 The `TrOpacityAnimation` class animates the opacity of a `UIView` or `CALayer`.
 */
@interface TrOpacityAnimation : TrLayerAnimation

/// --------------------------------
/// @name Examining Views and Layers
/// --------------------------------

/*!
 Checks if a opacity animation is in progress on a `UIView` or `CALayer` instance.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to examine.
 
 @return Returns `YES` if the `UIView` or `CALayer` has an opacity animation in progress.
 */
+ (BOOL)inProgressOn:(id<TrAnimatable>)viewOrLayer;

/// --------------------------
/// @name Creating Animaitions
/// --------------------------

/*!
 Creates an returns an animation that changes the opacity of a `UIView` or `CALayer`.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to animate.
 @param duration    The duration of the animation.
 @param delay       The delay before the animation begins.
 @param fromOpacity Animate from this opacity value.
 @param toOpacity   Animate to this opacity value.
 @param curve       The curvature of the animation.
 @param completion  A block that gets invokes when the animation completes.
 
 @return An opacity animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
            fromOpacity:(CGFloat)fromOpacity
              toOpacity:(CGFloat)toOpacity
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

/*!
 Creates an returns an animation that changes the opacity of a `UIView` or `CALayer`.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to animate.
 @param duration    The duration of the animation.
 @param delay       The delay before the animation begins.
 @param fromOpacity Animate from this opacity value.
 @param toOpacity   Animate to this opacity value.
 @param curve       The curvature of the animation.
 
 @return An opacity animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
            fromOpacity:(CGFloat)fromOpacity
              toOpacity:(CGFloat)toOpacity
                  curve:(TrCurve *)curve;

/*!
 Creates an returns an animation that changes the opacity of a `UIView` or `CALayer`.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to animate.
 @param duration    The duration of the animation.
 @param delay       The delay before the animation begins.
 @param fromOpacity Animate from this opacity value.
 @param toOpacity   Animate to this opacity value.
 
 @return An opacity animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
            fromOpacity:(CGFloat)fromOpacity
              toOpacity:(CGFloat)toOpacity;

/*!
 Creates an returns an animation that changes the opacity of a `UIView` or `CALayer`. The animation opacity will animate from the current opacity.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to animate.
 @param duration    The duration of the animation.
 @param delay       The delay before the animation begins.
 @param toOpacity   Animate to this opacity value.
 @param curve       The curvature of the animation.
 @param completion  A block that gets invokes when the animation completes.
 
 @discussion This method is for creating animations that begins from the `UIView` or `CALayer`s current opacity value.
 
 @return An opacity animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              toOpacity:(CGFloat)toOpacity
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

/*!
 Creates an returns an animation that changes the opacity of a `UIView` or `CALayer`. The animation opacity will animate from the current opacity.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to animate.
 @param duration    The duration of the animation.
 @param delay       The delay before the animation begins.
 @param toOpacity   Animate to this opacity value.
 @param curve       The curvature of the animation.
 
 @discussion This method is for creating animations that begins from the `UIView` or `CALayer`s current opacity value.
 
 @return An opacity animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              toOpacity:(CGFloat)toOpacity
                  curve:(TrCurve *)curve;

/*!
 Creates an returns an animation that changes the opacity of a `UIView` or `CALayer`. The animation opacity will animate from the current opacity.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to animate.
 @param duration    The duration of the animation.
 @param delay       The delay before the animation begins.
 @param toOpacity   Animate to this opacity value.
 
 @discussion This method is for creating animations that begins from the `UIView` or `CALayer`s current opacity value. It also uses linear curvature.
 
 @return An opacity animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              toOpacity:(CGFloat)toOpacity;

@end
