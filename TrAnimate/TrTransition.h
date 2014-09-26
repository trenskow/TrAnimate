//
//  TrTransition.h
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

#import "TrAnimationGroup.h"

@class TrCurve;

/*!
 The `TrTransition` class is an abstract class that provides basic functionality for creating transitions.
 
 ## Build-in Transitions
 
 The transitions below are provided by TrAnimate.
 
 - `TrFadeTransition`
 - `TrPushTransition`
 - `TrFlipTransition`
 
 ## Creating Transitions
 
 You create custom transitions by subclassing `TrTransition`. Transitions are defined - as opposed to animations - as a transition from one `UIView` object to another `UIView` object in a view hierarchy. Animations just animate a single `UIView` object.
 
 */
@interface TrTransition : TrAnimationGroup

/// --------------------------
/// @name Creating Transitions
/// --------------------------

/*!
 Returns a initiated `TrTransition` object.
 
 @param sourceView      The `UIView` object to transition from.
 @param destinationView The `UIView` object to transition to.
 @param duration        The duration of the transition.
 @param delay           The delay before the transition begins.
 @param curve           The curvature of the transition.
 @param completion      A block that gets invoked when the transition completes.
 
 @return A transition ready for setup.
 
 @discussion Use this when creating your custom animation in order to access the corrosponding properties when animations are setup.
 */
- (instancetype)initWithSourceView:(UIView *)sourceView
                   destinationView:(UIView *)destinationView
                          duration:(NSTimeInterval)duration
                             delay:(NSTimeInterval)delay
                             curve:(TrCurve *)curve
                        completion:(void (^)(BOOL finished))completion;

/// ---------------------------
/// @name Transition Properties
/// ---------------------------

/*!
 Returns the `UIView` object to transition from.
 */
@property (nonatomic,weak,readonly) UIView *sourceView;

/*!
 Returns the `UIView` object to transition to.
 */
@property (nonatomic,weak,readonly) UIView *destinationView;

/*!
 Returns the duration that needs to be applied to animations.
 */
@property (nonatomic,readonly) NSTimeInterval applyDuration;

/*!
 Returns the delay that needs to be applied to animations.
 */
@property (nonatomic,readonly) NSTimeInterval applyDelay;

/*!
 Returns the curvature that needs to be applied to animations.
 */
@property (nonatomic,copy,readonly) TrCurve *applyCurve;

/// ---------------------------
/// @name Setting up Animations
/// ---------------------------

/*!
 Notifies the transition that it needs to setup any animations needed for the transition.
 
 @discussion You can override this in your subclasses in order to setup the animations needed for the transition.
 */
- (void)setupAnimations;

@end
