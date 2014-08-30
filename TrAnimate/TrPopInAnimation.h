//
//  TrPopInAnimation.h
//  TrAnimate
//
//  Created by Kristian Trenskow on 30/08/14.
//  Copyright (c) 2014 Kristian Trenskow. All rights reserved.
//

#import <TrAnimate/TrAnimate.h>

@protocol TrAnimatable;

/*!
 The `TrPopInAnimation` pops in a `UIView` or `CALayer`.
 */
@interface TrPopInAnimation : TrAnimationGroup

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
