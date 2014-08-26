//
//  TrRotateAnimation.h
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
 Speciefies the rotation axis.
 */
typedef NS_OPTIONS(NSUInteger, TrRotateAnimationAxis) {
    /*! Rotate around the z-axis. Default. */
    TrRotateAnimationAxisZ = 0,
    /*! Rotate around the x-axis. */
    TrRotateAnimationAxisX,
    /*! Rotate around the y-axis. */
    TrRotateAnimationAxisY
};

/*!
 A animation that rotates a `UIView` or `CALayer` around an axis.
 */
@interface TrRotateAnimation : TrLayerAnimation

/*!
 Checks if a rotation animation is in progress on a `UIView` or `CALayer` instance.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to examine.
 @param axis The axis on which the animation is rotating.
 
 @return Returns `YES` if the `UIView` or `CALayer` has a rotation animation in progress.
 */
+ (BOOL)inProgressOn:(id<TrAnimatable>)viewOrLayer withAxis:(TrRotateAnimationAxis)axis;

/// -------------------------
/// @name Creating Animations
/// -------------------------

/*!
 Creates and returns an animation that rotates around a specified axis.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to animate.
 @param duration    The duration of the animation.
 @param delay       The delay of the animation.
 @param fromAngle   The angle to animate from.
 @param toAngle     The angle to animate to.
 @param axis        The axis of rotation.
 @param curve       The curvature of the animation.
 @param completion  A block that gets invokes when the animation completes.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              fromAngle:(CGFloat)fromAngle
                toAngle:(CGFloat)toAngle
                   axis:(TrRotateAnimationAxis)axis
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

/*!
 Creates and returns an animation that rotates around a specified axis.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to animate.
 @param duration    The duration of the animation.
 @param delay       The delay of the animation.
 @param fromAngle   The angle to animate from.
 @param toAngle     The angle to animate to.
 @param axis        The axis of rotation.
 @param curve       The curvature of the animation.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              fromAngle:(CGFloat)fromAngle
                toAngle:(CGFloat)toAngle
                   axis:(TrRotateAnimationAxis)axis
                  curve:(TrCurve *)curve;

/*!
 Creates and returns an animation that rotates around a specified axis.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to animate.
 @param duration    The duration of the animation.
 @param delay       The delay of the animation.
 @param fromAngle   The angle to animate from.
 @param toAngle     The angle to animate to.
 @param axis        The axis of rotation.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              fromAngle:(CGFloat)fromAngle
                toAngle:(CGFloat)toAngle
                   axis:(TrRotateAnimationAxis)axis;

/*!
 Creates and returns an animation that rotates around a specified axis. Animation rotates around the Z-axis.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to animate.
 @param duration    The duration of the animation.
 @param delay       The delay of the animation.
 @param fromAngle   The angle to animate from.
 @param toAngle     The angle to animate to.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
              fromAngle:(CGFloat)fromAngle
                toAngle:(CGFloat)toAngle;

/*!
 Creates and returns an animation that rotates around a specified axis. The rotation angle will animate from the current angle.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to animate.
 @param duration    The duration of the animation.
 @param delay       The delay of the animation.
 @param toAngle     The angle to animate to.
 @param axis        The axis of rotation.
 @param curve       The curvature of the animation.
 @param completion  A block that gets invokes when the animation completes.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                toAngle:(CGFloat)toAngle
                   axis:(TrRotateAnimationAxis)axis
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

/*!
 Creates and returns an animation that rotates around a specified axis. The rotation angle will animate from the current angle.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to animate.
 @param duration    The duration of the animation.
 @param delay       The delay of the animation.
 @param toAngle     The angle to animate to.
 @param axis        The axis of rotation.
 @param curve       The curvature of the animation.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                toAngle:(CGFloat)toAngle
                   axis:(TrRotateAnimationAxis)axis
                  curve:(TrCurve *)curve;

/*!
 Creates and returns an animation that rotates around a specified axis. The rotation angle will animate from the current angle.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to animate.
 @param duration    The duration of the animation.
 @param delay       The delay of the animation.
 @param toAngle     The angle to animate to.
 @param axis        The axis of rotation.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                toAngle:(CGFloat)toAngle
                   axis:(TrRotateAnimationAxis)axis;

/*!
 Creates and returns an animation that rotates around a specified axis. The rotation angle will animate from the current angle. Animation rotates around the Z-axis.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to animate.
 @param duration    The duration of the animation.
 @param delay       The delay of the animation.
 @param toAngle     The angle to animate to.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
                toAngle:(CGFloat)toAngle;

@end
