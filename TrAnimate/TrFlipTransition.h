//
//  TrFlipTransition.h
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

@import UIKit;

#import "TrTransition.h"

@class TrCurve;

/*!
 Specifies the direction of the flip.
 */
typedef NS_ENUM(NSInteger, TrFlipTransitionDirection) {
    /*! Flip the views in a downwards direction. */
    TrFlipTransitionDirectionDown,
    /*! Flip the views to the left. */
    TrFlipTransitionDirectionLeft,
    /*! Flip the views in a upwards direction. */
    TrFlipTransitionDirectionUp,
    /*! Flip the views to the right. */
    TrFlipTransitionDirectionRight
};

/*!
 The `TrFlipTransition` flips one view to another - replacing the origin view in the view hierarchy.
 */
@interface TrFlipTransition : TrTransition

/// -------------------------
/// @name Creating Transition
/// -------------------------

/*!
 Creates and returns a flip transition that flips `sourceView` to `destinationView`.
 
 @param sourceView      The `UIView` object to flip from. This view must be in a view hierarchy.
 @param destinationView The `UIView` object to flip to.
 @param duration        The duration of the flip transition.
 @param direction       The direction of the flip.
 @param delay           The delay before the flip transition begins.
 @param curve           The curvature of the flip transition.
 @param completion      A block that gets invoked when the flip transition completes.
 
 @return A flip transition ready to animate.
 */
+ (instancetype)transitionFrom:(UIView *)sourceView
                            to:(UIView *)destinationView
                      duration:(NSTimeInterval)duration
                     direction:(TrFlipTransitionDirection)direction
                         delay:(NSTimeInterval)delay
                         curve:(TrCurve *)curve
                    completion:(void (^)(BOOL finished))completion;

/*!
 Creates and returns a flip transition that flips `sourceView` to `destinationView`.
 
 @param sourceView      The `UIView` object to flip from. This view must be in a view hierarchy.
 @param destinationView The `UIView` object to flip to.
 @param duration        The duration of the flip transition.
 @param direction       The direction of the flip.
 @param delay           The delay before the flip transition begins.
 @param curve           The curvature of the flip transition.
 
 @return A flip transition ready to animate.
 */
+ (instancetype)transitionFrom:(UIView *)sourceView
                            to:(UIView *)destinationView
                      duration:(NSTimeInterval)duration
                     direction:(TrFlipTransitionDirection)direction
                         delay:(NSTimeInterval)delay
                         curve:(TrCurve *)curve;

/*!
 Creates and returns a flip transition that flips `sourceView` to `destinationView`.
 
 @param sourceView      The `UIView` object to flip from. This view must be in a view hierarchy.
 @param destinationView The `UIView` object to flip to.
 @param duration        The duration of the flip transition.
 @param direction       The direction of the flip.
 @param delay           The delay before the flip transition begins.
 
 @return A flip transition ready to animate.
 */
+ (instancetype)transitionFrom:(UIView *)sourceView
                            to:(UIView *)destinationView
                      duration:(NSTimeInterval)duration
                     direction:(TrFlipTransitionDirection)direction
                         delay:(NSTimeInterval)delay;

/*!
 Creates and returns a flip transition that flips `sourceView` to `destinationView`.
 
 @param sourceView      The `UIView` object to flip from. This view must be in a view hierarchy.
 @param destinationView The `UIView` object to flip to.
 @param duration        The duration of the flip transition.
 @param direction       The direction of the flip.
 
 @return A flip transition ready to animate.
 */
+ (instancetype)transitionFrom:(UIView *)sourceView
                            to:(UIView *)destinationView
                      duration:(NSTimeInterval)duration
                     direction:(TrFlipTransitionDirection)direction;

@end
