//
//  TrPositionAnimation.h
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
 Specifies the anchor point of the position.
 */
typedef NS_OPTIONS(NSUInteger, TrPositionAnimationAnchor) {
    /*! Automatically detect origin. `UIView`s is anchored top left. `CALayer`s is anchored center. Default. */
    TrPositionAnimationAnchorAutomatic = 0,
    /*! Origin in the center of the view or layer. */
    TrPositionAnimationAnchorCenter,
    /*! Origin at the top left of the view or layer. */
    TrPositionAnimationAnchorTopLeft
};

/*!
 The `TrPositionAnimation` changes the positions a `UIView` or `CALayer`.
 */
@interface TrPositionAnimation : TrLayerAnimation

/// --------------------------------
/// @name Examining Views and Layers
/// --------------------------------

/*!
 Checks if a position animation is in progress on a `UIView` or `CALayer` instance.
 
 @param viewOrLayer The `UIView` or `CALayer` you want to examine.
 
 @return Returns `YES` if the `UIView` or `CALayer` has an move animation in progress.
 */
+ (BOOL)inProgressOn:(id<TrAnimatable>)viewOrLayer;

/// --------------------------
/// @name Creating Animaitions
/// --------------------------

/*!
 Creates and returns an animation that moves a `UIView` or `CALayer`.
 
 @param viewOrLayer  The `UIView` or `CALayer` you want to animate.
 @param duration     The duration of the animation.
 @param delay        The delay before the animation begins.
 @param fromPosition The start position of the animation.
 @param toPosition   The end position of the animation.
 @param anchor       The anchor of position.
 @param curve        The curvature of the animation.
 @param completion   A block that gets invokes when animation completes.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
           fromPosition:(CGPoint)fromPosition
             toPosition:(CGPoint)toPosition
                 anchor:(TrPositionAnimationAnchor)anchor
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

/*!
 Creates and returns an animation that moves a `UIView` or `CALayer`.
 
 @param viewOrLayer  The `UIView` or `CALayer` you want to animate.
 @param duration     The duration of the animation.
 @param delay        The delay before the animation begins.
 @param fromPosition The start position of the animation.
 @param toPosition   The end position of the animation.
 @param anchor       The anchor of position.
 @param curve        The curvature of the animation.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
           fromPosition:(CGPoint)fromPosition
             toPosition:(CGPoint)toPosition
                 anchor:(TrPositionAnimationAnchor)anchor
                  curve:(TrCurve *)curve;

/*!
 Creates and returns an animation that moves a `UIView` or `CALayer`.
 
 @param viewOrLayer  The `UIView` or `CALayer` you want to animate.
 @param duration     The duration of the animation.
 @param delay        The delay before the animation begins.
 @param fromPosition The start position of the animation.
 @param toPosition   The end position of the animation.
 @param anchor       The anchor of position.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
           fromPosition:(CGPoint)fromPosition
             toPosition:(CGPoint)toPosition
                 anchor:(TrPositionAnimationAnchor)anchor;

/*!
 Creates and returns an animation that moves a `UIView` or `CALayer`.
 
 @param viewOrLayer  The `UIView` or `CALayer` you want to animate.
 @param duration     The duration of the animation.
 @param delay        The delay before the animation begins.
 @param fromPosition The start position of the animation.
 @param toPosition   The end position of the animation.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
           fromPosition:(CGPoint)fromPosition
             toPosition:(CGPoint)toPosition;

/*!
 Creates and returns an animation that moves a `UIView` or `CALayer`. The animation position will animate from the current position.
 
 @param viewOrLayer  The `UIView` or `CALayer` you want to animate.
 @param duration     The duration of the animation.
 @param delay        The delay before the animation begins.
 @param toPosition   The end position of the animation.
 @param anchor       The anchor of position.
 @param curve        The curvature of the animation.
 @param completion   A block that gets invokes when animation completes.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
             toPosition:(CGPoint)toPosition
                 anchor:(TrPositionAnimationAnchor)anchor
                  curve:(TrCurve *)curve
             completion:(void (^)(BOOL finished))completion;

/*!
 Creates and returns an animation that moves a `UIView` or `CALayer`. The animation position will animate from the current position.
 
 @param viewOrLayer  The `UIView` or `CALayer` you want to animate.
 @param duration     The duration of the animation.
 @param delay        The delay before the animation begins.
 @param toPosition   The end position of the animation.
 @param anchor       The anchor of position.
 @param curve        The curvature of the animation.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
             toPosition:(CGPoint)toPosition
                 anchor:(TrPositionAnimationAnchor)anchor
                  curve:(TrCurve *)curve;

/*!
 Creates and returns an animation that moves a `UIView` or `CALayer`. The animation position will animate from the current position.
 
 @param viewOrLayer  The `UIView` or `CALayer` you want to animate.
 @param duration     The duration of the animation.
 @param delay        The delay before the animation begins.
 @param toPosition   The end position of the animation.
 @param anchor       The anchor of position.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
             toPosition:(CGPoint)toPosition
                 anchor:(TrPositionAnimationAnchor)anchor;

/*!
 Creates and returns an animation that moves a `UIView` or `CALayer`. The animation position will animate from the current position.
 
 @param viewOrLayer  The `UIView` or `CALayer` you want to animate.
 @param duration     The duration of the animation.
 @param delay        The delay before the animation begins.
 @param toPosition   The end position of the animation.
 
 @return An animation ready to animate.
 */
+ (instancetype)animate:(id<TrAnimatable>)viewOrLayer
               duration:(NSTimeInterval)duration
                  delay:(NSTimeInterval)delay
             toPosition:(CGPoint)toPosition;

@end
