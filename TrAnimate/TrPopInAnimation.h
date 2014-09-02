//
//  TrPopInAnimation.h
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

#import "TrScaleAnimation.h"

/*!
 The `TrPopInAnimation` pops in a `UIView` or `CALayer`.
 */
@interface TrPopInAnimation : TrScaleAnimation

/// ------------------------
/// @name Creating Animation
/// ------------------------

/*!
 Creates and returns an animation that pops in a `UIView` or `CALayer`.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to pop in.
 @param duration    The duration of the pop in.
 @param delay       The delay before the pop in begins.
 @param elastic     Specifies if the pop in should ease out in an elastic fashion - as oppose to a slight overshoot in size which is the default.
 @param completion  A block that gets invoked when the pop in is complete.
 
 @return A pop in animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                elastic:(BOOL)elastic
             completion:(void(^)(BOOL finished))completion;

/*!
 Creates and returns an animation that pops in a `UIView` or `CALayer`.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to pop in.
 @param duration    The duration of the pop in.
 @param delay       The delay before the pop in begins.
 @param elastic     Specifies if the pop in should ease out in an elastic fashion - as oppose to a slight overshoot in size which is the default.
 
 @return A pop in animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                elastic:(BOOL)elastic;

/*!
 Creates and returns an animation that pops in a `UIView` or `CALayer`. The animation eases out back - meaning it overshoots it's target scale before coming back to it's proper size.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to pop in.
 @param duration    The duration of the pop in.
 @param delay       The delay before the pop in begins.
 
 @return A pop in animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay;

/*!
 Creates and returns an animation that pops in a `UIView` or `CALayer`. The animation eases out back - meaning it overshoots it's target scale before coming back to it's proper size.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to pop in.
 @param duration    The duration of the pop in.
 
 @return A pop in animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration;

/*!
 Creates and returns an animation that pops in a `UIView` or `CALayer`. The animation eases out back - meaning it overshoots it's target scale before coming back to it's proper size. With this method the pop in duration is 0.2 seconds.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to pop in.
 
 @return A pop in animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer;

@end
