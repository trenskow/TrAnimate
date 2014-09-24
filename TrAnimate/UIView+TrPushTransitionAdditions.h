//
//  UIView+TrPushTransitionAdditions.h
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

#import "TrPushTransition.h"

@class TrCurve;

/*!
 A category to `UIVIew` with convenience method for creating push transitions.
 
 @discussion See `TrPushTransition` for information about this type of transition.
 */
@interface UIView (TrPushTransitionAdditions)

/// -------------------------------
/// @name Creating Push Transitions
/// -------------------------------

/*!
 Creates and returns a push transition.
 
 @param destinationView The `UIView` object to push to.
 @param duration        The duration of the push transition.
 @param edge            The direction of the push transition.
 @param delay           The delay before the push transition begins.
 @param curve           The curvature of the push transition.
 @param completion      A block that gets invoked when the push transition completes.
 
 @return A push transition ready to animate.
 */
- (TrPushTransition *)pushTo:(UIView *)destinationView
                    duration:(NSTimeInterval)duration
                        edge:(TrMoveAnimationEdge)edge
                       delay:(NSTimeInterval)delay
                       curve:(TrCurve *)curve
                  completion:(void (^)(BOOL finished))completion;

/*!
 Creates and returns a push transition.
 
 @param destinationView The `UIView` object to transition to.
 @param duration        The duration of the push transition.
 @param edge            The direction of the push transition.
 @param delay           The delay before the push transition begins.
 @param curve           The curvature of the push transition.
 
 @return A push transition ready to animate.
 */
- (TrPushTransition *)pushTo:(UIView *)destinationView
                    duration:(NSTimeInterval)duration
                        edge:(TrMoveAnimationEdge)edge
                       delay:(NSTimeInterval)delay
                       curve:(TrCurve *)curve;

/*!
 Creates and returns a push transition.
 
 @param destinationView The `UIView` object to transition to.
 @param duration        The duration of the push transition.
 @param edge            The direction of the push transition.
 @param delay           The delay before the push transition begins.
 
 @return A push transition ready to animate.
 */
- (TrPushTransition *)pushTo:(UIView *)destinationView
                    duration:(NSTimeInterval)duration
                        edge:(TrMoveAnimationEdge)edge
                       delay:(NSTimeInterval)delay;

/*!
 Creates and returns a push transition.
 
 @param destinationView The `UIView` object to transition to.
 @param duration        The duration of the push transition.
 @param edge            The direction of the push transition.
 
 @return A push transition ready to animate.
 */
- (TrPushTransition *)pushTo:(UIView *)destinationView
                    duration:(NSTimeInterval)duration
                        edge:(TrMoveAnimationEdge)edge;

@end
